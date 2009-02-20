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
  
end
