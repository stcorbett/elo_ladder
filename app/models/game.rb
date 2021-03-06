# == Schema Information
# Schema version: 20090604124054
#
# Table name: games
#
#  id         :integer         not null, primary key
#  winner_id  :integer
#  loser_id   :integer
#  status     :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Game < ActiveRecord::Base
  
  belongs_to :winner, :class_name => "User", :foreign_key => "winner_id"
  belongs_to :loser,  :class_name => "User", :foreign_key => "loser_id"
  
  validates_presence_of :winner_id, :loser_id
  
  def after_create
    winner.rating, loser.rating = winner.new_rating_against(loser, true), loser.new_rating_against(winner, false)
    winner.save and loser.save
  end
  
  def validate
    self.errors.add_to_base("cannot have a match with same winner and loser") if self.winner == self.loser
  end
  
end
