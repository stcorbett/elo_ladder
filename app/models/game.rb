# == Schema Information
# Schema version: 20090220032913
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
  belongs_to :loser, :class_name => "User", :foreign_key => "loser_id"
  
  validates_presence_of :winner_id, :loser_id
  
end