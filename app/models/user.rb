# == Schema Information
# Schema version: 20090220032913
#
# Table name: users
#
#  id                :integer         not null, primary key
#  email             :string(255)
#  crypted_password  :string(255)
#  password_salt     :string(255)
#  persistence_token :string(255)
#  login_count       :integer
#  last_request_at   :datetime
#  last_login_at     :datetime
#  current_login_at  :datetime
#  last_login_ip     :string(255)
#  current_login_ip  :string(255)
#  name              :string(255)
#  rating            :integer         default(1600)
#  created_at        :datetime
#  updated_at        :datetime
#

class User < ActiveRecord::Base

  has_many :won_games, :class_name => "Game", :foreign_key => "winner_id"
  has_many :lost_games, :class_name => "Game", :foreign_key => "loser_id"
  
  validates_presence_of :name
  
  acts_as_authentic :login_field => :email


  def expected_score_against(other)
    (1 / (1 + 10**((other.rating - self.rating)/400.0))).to_f
  end
  
end
