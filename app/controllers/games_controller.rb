class GamesController < ApplicationController

  before_filter :require_user

  def index
    @games = Game.find :all, :conditions => ["winner_id = ? or loser_id = ?", current_user.id, current_user.id]

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @games }
    end
  end

  def create
    @game = Game.new(params[:game])
    @game.winner = current_user

    respond_to do |format|
      if @game.save
        flash[:notice] = 'Game was successfully recorded.'
        format.html { redirect_to root_path }
        format.xml  { render :xml => @game, :status => :created, :location => @game }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @game.errors, :status => :unprocessable_entity }
      end
    end
  end

  # TODO: allow users to contest a game within 24 hours of posting it
  # def update
  #   @game = Game.find(params[:id])
  # 
  #   respond_to do |format|
  #     if @game.update_attributes(params[:game])
  #       flash[:notice] = 'Game was successfully contested.'
  #       format.html { redirect_to games_path }
  #       format.xml  { head :ok }
  #     else
  #       format.html { render :action => "edit" }
  #       format.xml  { render :xml => @game.errors, :status => :unprocessable_entity }
  #     end
  #   end
  # end

end