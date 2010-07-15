class SiteController < ApplicationController
  
  @@callback_url = 'http://socialopoly.heroku.com/auth'
  
  #@@callback_url = 'http://localhost:3000/auth'
  
  
  @@consumer_key = "HaiRIn5MeRsKvFzAMDwSdA"
  
  #@@consumer_key = "121910256-cqKSwqqBkHYnQ0hd49Wxq5hJr5eeNpRU8R1qNt2I"
  
  @@consumer_secret = "w0XlgDN10lM91rR1WTjBU0IBAmK9wnuGDxbVjcWM5a4"
  #@@consumer_secret = "0ynyPFutHSK9zlYtkK5fI7kvRx64JRCB5O73yRx94"
  
  def index
    @users = User.find(:all, :order => "followers DESC")
  end
  
  def connect
    client = TwitterOAuth::Client.new(
        :consumer_key => @@consumer_key,
        :consumer_secret => @@consumer_secret
    )
    request_token = client.request_token(:oauth_callback => @@callback_url)
    session[:token] = request_token.token
    session[:secret] = request_token.secret
    
    # redirect_to "http://#{oauth.request_token.authorize_url}"
    redirect_to request_token.authorize_url
  end
  
  def auth
    client = TwitterOAuth::Client.new  
    access_token = client.authorize(
      session[:token],
      session[:secret],
      :oauth_verifier => params[:oauth_verifier]
    )
    
    @user = User.find_by_twitter_id(client.user.first["id"].to_s)
    
    if @user
      @user.avatar_url = client.user.first["user"]["profile_image_url"]
      @user.name = client.user.first["name"]
      @user.username = client.user.first["user"]["screen_name"]
      @user.followers = client.all_followers.size
    else
      @user = User.create({
        :avatar_url => client.user.first["user"]["profile_image_url"],
        :twitter_id => client.user.first["id"],
        :name => client.user.first["name"],
        :username => client.user.first["user"]["screen_name"],
        :followers => client.all_followers.size
      })
      
    end    
  end
  
end
