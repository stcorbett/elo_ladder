class Notifier < ActionMailer::Base

  def password_reset_instructions(user, reset_url)
    setup
    subject       'Password Reset Instructions'
    recipients    user.email
    sent_on       Time.now
    body          :edit_password_reset_url => reset_url
  end
  
  
  protected
  
  def setup
    @from = CONFIG['mailer']['from_address']
    content_type 'text/html'
  end

end
