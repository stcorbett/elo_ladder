class UsersController < ApplicationController
  
  before_filter :require_user, :only => [:edit, :update]
  before_filter :require_no_user, :only => [:new, :create]
  
  def index
    @users = User.find :all, :order => "rating DESC"

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @users }
    end
  end
  
  def show
    @user = User.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @user }
    end
  end

  def new
    @user = User.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @user }
    end
  end

  def edit
    @user = User.find(current_user.id)
  end

  def create
    @user = User.new(params[:user])

    respond_to do |format|
      if @user.save
        flash[:notice] = 'Your account has been successfully created.'
        format.html { redirect_to root_path }
        format.xml  { render :xml => @user, :status => :created, :location => @user }
      else
        format.html { render :action => 'new' }
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    @user = User.find(current_user.id)

    respond_to do |format|
      if @user.update_attributes(params[:user])
        flash[:notice] = 'Your account was successfully updated.'
        format.html { redirect_to @user }
        format.xml  { head :ok }
      else
        format.html { render :action => 'edit' }
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end
  
end
