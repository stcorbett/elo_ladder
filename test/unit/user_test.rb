require 'test_helper'

class UserTest < ActiveSupport::TestCase
  
  context "validations" do
    setup do
      @user = Factory(:user)
    end

    should_have_many :won_games
    should_have_many :lost_games

    should_require_attributes :name
    should_require_unique_attributes :email
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
  
end
