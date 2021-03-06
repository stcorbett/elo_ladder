require 'test_helper'

class GameTest < ActiveSupport::TestCase
  
  context "validations" do
    setup { @game = Factory(:game) }
    
    should_belong_to :winner
    should_belong_to :loser
    
    should_require_attributes :winner_id, :loser_id
    
    should "not allow match against self" do
      user = Factory(:user)
      game = Factory.build(:game, :winner => user, :loser => user)
      
      assert !game.valid?
      assert game.errors["base"] == "cannot have a match with same winner and loser"
    end
  end
  
  context "rating calculations" do
    setup do
      @user1 = Factory(:user, :rating => 1613)
      @user2 = Factory(:user, :rating => 1609)
      @game = Factory(:game, :winner => @user1, :loser => @user2)
    end
    
    should "adjust users' ratings after a game" do
      @user1.reload
      @user1.rating.should == 1628
      
      @user2.reload
      @user2.rating.should == 1593
    end
  end
  
end
