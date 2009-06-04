# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_elo_ladder_session',
  :secret      => '9d6727b2c8afa9aa693d36291aa029803e609d1f1e35414ffc797683624d8b5de9d5f527567ca941aa3213133a6ad0f9f6ecf3a2a9efc9f684f1a7ceebdc27b8'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
