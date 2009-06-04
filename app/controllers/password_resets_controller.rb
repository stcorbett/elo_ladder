class PasswordResetsController < ApplicationController

  before_filter :load_user_using_perishable_token, :only => [:edit, :update]
  before_filter :require_no_user


  def new
  end

  def create
    @user = User.find_by_email(params[:email])
    if @user
      @user.deliver_password_reset_instructions!(edit_password_reset_url(@user.perishable_token))
      flash[:notice] = 'Instructions to reset your password have been emailed to you. Please check your email.'
      redirect_to root_url
    else
      flash[:error] = 'No user was found with that email address.'
      render :action => :new
      flash.discard
    end
  end
  
  def edit
  end

  def update
    @user.password = params[:user][:password]
    @user.password_confirmation = params[:user][:password_confirmation]
    
    @user_session = UserSession.new(:email => @user.email, :password => params[:user][:password])
    
    if @user.save and @user_session.save
      flash[:notice] = 'Password successfully updated.'
      redirect_to root_url
    else
      render :action => :edit
    end
  end


  private

  def load_user_using_perishable_token
    @user = User.find_by_perishable_token(params[:id])
    unless @user
      flash[:error] = 'We\'re sorry, but we could not locate your account.'
      redirect_to root_url
    end
  end

end
