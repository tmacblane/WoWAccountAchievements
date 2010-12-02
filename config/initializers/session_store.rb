# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_WoWAchievements_session',
  :secret      => '227dad054beb8343a03e240e25ed273d1e2f8af43e0a7621d3c865040e0a94fd75b125b1efdfba75ed987fea5a617676dec2990ce418e5423ab470ca0b72e1ab'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
