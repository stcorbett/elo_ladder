RAILS_GEM_VERSION = '2.3.2' unless defined? RAILS_GEM_VERSION

require File.join(File.dirname(__FILE__), 'boot')

Rails::Initializer.run do |config|

  config.time_zone = 'UTC'

  # gem dependencies
  config.gem 'authlogic', :version => '2.0.13'
  config.gem 'haml'
  config.gem 'mhennemeyer-matchy',      :source => 'http://gems.github.com', :lib => 'matchy' 
  config.gem 'mislav-will_paginate',    :source => 'http://gems.github.com', :lib => 'will_paginate' 
  config.gem 'thoughtbot-factory_girl', :source => 'http://gems.github.com', :lib => 'factory_girl'
  config.gem 'thoughtbot-shoulda',      :source => 'http://gems.github.com', :lib => 'shoulda/rails'

  CONFIG = YAML::load(File.open("#{RAILS_ROOT}/config/settings.yml"))[RAILS_ENV]

end

Sass::Plugin.options[:style] = :compressed if RAILS_ENV == 'production'
Sass::Plugin.options[:style] = :expanded if   RAILS_ENV == 'development'

ActionView::Base.default_form_builder = CustomFormBuilder

ActionView::Base.field_error_proc = Proc.new do |html_tag, instance|
  html_tag =~ /<label/ ? "<span class=\"label-with-errors\">#{html_tag}</span>" : "<span class=\"field-with-errors\">#{html_tag}</span>" 
end

ActionMailer::Base.smtp_settings = {
  :tls => CONFIG['mailer']['use_tls'],
  :address => CONFIG['mailer']['smtp_address'],
  :port => CONFIG['mailer']['smtp_port'],
  :domain => CONFIG['mailer']['smtp_domain'],
  :authentication => CONFIG['mailer']['smtp_authentication'].to_sym,
  :user_name => CONFIG['mailer']['smtp_user_name'],
  :password => CONFIG['mailer']['smtp_password']
}

ActionController::Base.filter_parameter_logging :password
