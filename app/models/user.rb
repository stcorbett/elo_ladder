# == Schema Information
# Schema version: 20090604124054
#
# Table name: users
#
#  id                 :integer         not null, primary key
#  email              :string(255)
#  crypted_password   :string(255)
#  password_salt      :string(255)
#  persistence_token  :string(255)
#  perishable_token   :string(255)
#  login_count        :integer
#  failed_login_count :integer
#  last_request_at    :datetime
#  current_login_at   :datetime
#  last_login_at      :datetime
#  current_login_ip   :string(255)
#  last_login_ip      :string(255)
#  name               :string(255)
#  rating             :integer         default(1600)
#  created_at         :datetime
#  updated_at         :datetime
#

class User < ActiveRecord::Base

  has_many :games, :finder_sql => 'SELECT * FROM games WHERE (games.winner_id = #{self.id} OR games.loser_id = #{self.id})'
  has_many :won_games,  :class_name => "Game", :foreign_key => "winner_id"
  has_many :lost_games, :class_name => "Game", :foreign_key => "loser_id"

  validates_presence_of :name
  validates_uniqueness_of :name
  validates_length_of :name, :in => 4..25

  acts_as_authentic do |c|
    c.validates_format_of_email_field_options = { :with => Authlogic::Regex.email, :message => 'is invalid' }
  end
 
  attr_accessible :email, :password, :password_confirmation, :name
  attr_serializable :id, :name, :updated_at, :created_at
  
  def expected_score_against(opponent)
    (1 / (1 + 10**((opponent.rating - self.rating)/400.0))).to_f
  end
  
  def new_rating_against(opponent, win = true)
    score = win ? 1 : 0
    k = self.rating > 2200 ? 16 : 32
    (self.rating + k * (score - expected_score_against(opponent))).to_i
  end
  
  def deliver_password_reset_instructions!
    reset_perishable_token!
    Notifier.deliver_password_reset_instructions(self)
  end
  
  def deliver_password_reset_instructions!(reset_url)
    reset_perishable_token!
    Notifier.deliver_password_reset_instructions(self, reset_url)
  end
  
  def to_param
    "#{id}-#{name.downcase.gsub(/[^[:alnum:]^ ]/, '').gsub(' ', '-')}"[0..75]
  end

end
