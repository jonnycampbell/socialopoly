class SiteController < ApplicationController

  def index

  end
  
  def connect
    callback_url = 'http://socialopoly.heroku.com/auth'
    consumer_key = "HaiRIn5MeRsKvFzAMDwSdA"
    consumer_secret = "w0XlgDN10lM91rR1WTjBU0IBAmK9wnuGDxbVjcWM5a4"
    
    oauth = Twitter::OAuth.new(consumer_key, consumer_secret)
    session['token'] = oauth.request_token.token
    session['secret'] = oauth.request_token.secret

    oauth.set_callback_url(callback_url)
    redirect_to "http://#{oauth.request_token.authorize_url}"
  end
  
  def auth
    oauth = Twitter::OAuth.new(consumer_key, consumer_secret)
    oauth.authorize_from_request(session['token'], session['secret'], params['oauth_verifier'])

    client = Twitter::Base.new(oauth)
    
    @follower_count = client.follower_ids.size
    debugger
    "blah"
  end
  
end
