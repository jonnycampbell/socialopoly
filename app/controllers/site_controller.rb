class SiteController < ApplicationController
  
  @@callback_url = 'http://socialopoly.heroku.com/auth'
  
  #@@callback_url = 'http://localhost:3000/auth'
  
  
  @@consumer_key = "HaiRIn5MeRsKvFzAMDwSdA"
  
  #@@consumer_key = "121910256-cqKSwqqBkHYnQ0hd49Wxq5hJr5eeNpRU8R1qNt2I"
  
  @@consumer_secret = "w0XlgDN10lM91rR1WTjBU0IBAmK9wnuGDxbVjcWM5a4"
  #@@consumer_secret = "0ynyPFutHSK9zlYtkK5fI7kvRx64JRCB5O73yRx94"
  
  def index

  end
  
  def connect

    
    # oauth = Twitter::OAuth.new(@@consumer_key, @@consumer_secret)
    # session['token'] = oauth.request_token.token
    # session['secret'] = oauth.request_token.secret
    # 
    # debugger 
    # 
    # oauth.set_callback_url(@@callback_url)
    
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
    # oauth = Twitter::OAuth.new(@@consumer_key, @@consumer_secret)
    # 
    # logger.warn "TOKEN:" + session['token']
    # logger.warn "SECRET:" + session['secret']
    # 
    # oauth.authorize_from_request(session['token'], session['secret'], params['oauth_verifier'])
    # client = Twitter::Base.new(oauth)
    # 
    # @follower_count = client.follower_ids.size
    # "blah"
    
    access_token = client.authorize(
      session[:token],
      session[:secret],
      :oauth_verifier => params[:oauth_verifier]
    )
    @follower_count = client.all_followers.size
  end
  
end
