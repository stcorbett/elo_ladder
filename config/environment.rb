# Be sure to restart your server when you modify this file

# Uncomment below to force Rails into production mode when
# you don't control web/app server and can't set it the proper way
# ENV['RAILS_ENV'] ||= 'production'

# Specifies gem version of Rails to use when vendor/rails is not present
RAILS_GEM_VERSION = '2.2.2' unless defined? RAILS_GEM_VERSION

# Bootstrap the Rails environment, frameworks, and default configuration
require File.join(File.dirname(__FILE__), 'boot')

Rails::Initializer.run do |config|

  config.time_zone = 'UTC'
  config.action_controller.session = {
    :session_key => '_elo_ladder_session',
    :secret      => '2ea4c27e1e7d360b11d6086feb3b67a4fb533b36266a7e9773dbfaf6783b6ee3849143386386fefa2710a25c848f5e1b46d6965e232b483b9f6b530ca6d9b929'
  }

  config.gem "haml"
  config.gem "thoughtbot-factory_girl", :lib => "factory_girl",  :source => "http://gems.github.com"
  config.gem "sqlite3-ruby",            :lib => "sqlite3"
  config.gem 'thoughtbot-shoulda',      :lib => 'shoulda/rails', :source => "http://gems.github.com"
  config.gem 'jeremymcanally-matchy',   :lib => 'matchy',        :source => "http://gems.github.com"
  config.gem 'authlogic'
  config.gem 'rubyist-aasm',            :lib => 'aasm',          :source => 'http://gems.github.com'
  config.gem 'jeremymcanally-matchy',   :lib => 'matchy',        :source => 'http://gems.github.com'

end

ActionView::Base.field_error_proc = Proc.new { |html_tag, instance| "<span class=\"field-with-errors\">#{html_tag}</span>" }
ActionView::Base.default_form_builder = CustomFormBuilder

config = YAML::load(File.open("#{RAILS_ROOT}/config/settings.yml"))

SITE_NAME    = config["site_name"]
SITE_URL     = config["url"]
FROM_ADDRESS = config["email"]["from_address"]

ActionMailer::Base.smtp_settings = {
  :tls => config["email"]["use_tls"],
  :address => config["email"]["smtp_address"],
  :port => config["email"]["smtp_port"],
  :domain => config["email"]["smtp_domain"],
  :authentication => config["email"]["smtp_authentication"].to_sym,
  :user_name => config["email"]["smtp_user_name"],
  :password => config["email"]["smtp_password"]
}