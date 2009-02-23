class Notifier < ActionMailer::Base

  default_url_options[:host] = Settings.url

  def password_reset_instructions(user)
    setup
    subject       "Password Reset Instructions"
    recipients    user.email
    sent_on       Time.now
    body          :edit_password_reset_url => edit_password_reset_url(user.perishable_token)
  end
  
  
  protected
  
  def setup
    @from = Settings.email["from_address"]
    
    content_type "text/html"
    
    ActionMailer::Base.smtp_settings = {
      :tls => Settings.email["use_tls"],
      :address => Settings.email["smtp_address"],
      :port => Settings.email["smtp_port"],
      :domain => Settings.email["smtp_domain"],
      :authentication => Settings.email["smtp_authentication"].to_sym,
      :user_name => Settings.email["smtp_user_name"],
      :password => Settings.email["smtp_password"]
    }
  end

end
