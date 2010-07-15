# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_socialopoly_session',
  :secret      => '946a03e37969a786a7b495befaae2ee1493c1d88c9437c6a1fdd59f69804b800eb56d92ae21391363502498c4d41f103ba7b6320969756e90aab6cfb876a59a1'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
