require 'test_helper'

class GameTest < ActiveSupport::TestCase
  
  context "validations" do
    setup do
      @game = Factory(:game)
    end
    
    should_belong_to :winner
    should_belong_to :loser
    
    should_require_attributes :winner_id, :loser_id
  end
  
end
