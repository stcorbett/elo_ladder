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
  
  should "calculate expected score against another player" do
    user1 = Factory(:user, :rating => 1613)
    user2 = Factory(:user, :rating => 1609)
    user3 = Factory(:user, :rating => 1477)
    
    user1.expected_score_against(user2).to_s.should == "0.505756208411145"
    user1.expected_score_against(user3).to_s.should == "0.686300257683312"
  end
  
end
