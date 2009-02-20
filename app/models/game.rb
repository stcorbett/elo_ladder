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
end
