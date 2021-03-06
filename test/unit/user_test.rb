require 'test_helper'

class UserTest < ActiveSupport::TestCase

  context "validations" do
    setup { @user = Factory(:user) }
    
    should_have_many :won_games
    should_have_many :lost_games

    should_require_attributes :name
    should_require_unique_attributes :email
    should_ensure_length_in_range :name, (4..25)
  end
  
  context "rating calculations" do
    setup do
      @user1 = Factory(:user, :rating => 1613)
      @user2 = Factory(:user, :rating => 1609)
      @user3 = Factory(:user, :rating => 1477)
    end
    
    should "calculate expected score against another player" do
      @user1.expected_score_against(@user2).to_s.should == "0.505756208411145"
      @user1.expected_score_against(@user3).to_s.should == "0.686300257683312"
    end
    
    should "calculate new rating after winning or losing against other player" do
      @user1.new_rating_against(@user2, true).should == 1628
      @user1.new_rating_against(@user3, true).should == 1623
      @user1.new_rating_against(@user2, false).should == 1596
      @user1.new_rating_against(@user3, false).should == 1591
    end
  end
  
  context "game win-loss counters and finders" do
    setup do
      @user1 = Factory(:user, :rating => 1613)
      @user2 = Factory(:user, :rating => 1609)
      @user3 = Factory(:user, :rating => 1477)
      @game1 = Factory(:game, :winner_id => @user1.id, :loser_id => @user2.id)
    end
    
    context "games_against" do
      should "return the number of games two users have played" do
        @user1.num_games_against(@user2).should == @user2.num_games_against(@user1)
        @user1.num_games_against(@user2).should == 1
      end
      
      should "return the games two users have played" do
        @user1.games_against(@user2).should == @user2.games_against(@user1)
        @user1.games_against(@user2).should == [@game1]
      end
    end
    
    context "wins_against and losses_against" do
      setup do
        @game2 = Factory(:game, :winner_id => @user1.id, :loser_id => @user2.id)
        @game3 = Factory(:game, :winner_id => @user2.id, :loser_id => @user1.id)
      end
      
      should "return the number of wins and losses between the two users" do
        @user1.num_wins_against(@user2).should == @user2.num_losses_against(@user1)
        @user1.num_wins_against(@user2).should == 2

        @user1.num_losses_against(@user2).should == @user2.num_wins_against(@user1)
        @user1.num_losses_against(@user2).should == 1
      end
      
      should "return the won and lost games between the two users" do
        @user1.wins_against(@user2).should == @user2.losses_against(@user1)
        @user1.wins_against(@user2).should include(@game2)
        @user1.wins_against(@user2).should include(@game1)
        
        @user1.losses_against(@user2).should == @user2.wins_against(@user1)
        @user1.losses_against(@user2).should == [@game3]
      end
      
    end
    
  end

end
