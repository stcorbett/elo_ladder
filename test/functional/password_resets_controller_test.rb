require 'test_helper'

class PasswordResetsControllerTest < ActionController::TestCase

  context "responding to POST create" do
    setup do
      @user = Factory(:user)
      post :create, :email => @user.email
    end

    should "set flash, send email and redirect user" do
      assert flash[:notice] == "Instructions to reset your password have been sent to you. Please check your email."
      assert_sent_email do |email|
        email.subject =~ /Password Reset Instructions/ &&
        email.to.include?(@user.email)
      end
      assert_redirected_to root_url
    end
  end
  
  context "responding to PUT update" do
    setup do
      @user = Factory(:user)
      put :update, :id => @user.perishable_token, :user => {:password => "newpass", :password_confirmation => "newpass"}
    end

    should "set flash and redirect user" do
      assert flash[:notice] == "Password successfully updated"
      assert_redirected_to login_path
    end
  end

end
