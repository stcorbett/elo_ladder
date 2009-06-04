class UserSessionsController < ApplicationController

  before_filter :require_no_user, :only => [:new, :create]

  def new
    @user_session = UserSession.new
  end

  def create
    @user_session = UserSession.new(params[:user_session])
    
    if @user_session.save
      flash[:notice] = 'You have been successfully logged in.'
      redirect_back_or_default
    else
      render :action => :new
    end
  end

  def destroy
    current_user_session.destroy
    flash[:notice] = 'You have been successfully logged out.'
    redirect_to root_path
  end

end
