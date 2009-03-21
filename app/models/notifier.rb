class Notifier < ActionMailer::Base

  default_url_options[:host] = SITE_URL

  def password_reset_instructions(user)
    setup
    subject       "Password Reset Instructions"
    recipients    user.email
    sent_on       Time.now
    body          :edit_password_reset_url => edit_password_reset_url(user.perishable_token)
  end
  
  
  protected
  
  def setup
    @from = FROM_ADDRESS
    content_type "text/html"
  end

end
