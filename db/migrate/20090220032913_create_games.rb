class CreateGames < ActiveRecord::Migration
  def self.up
    create_table :games do |t|
      t.integer :winner_id,  :loser_id
      t.string :status
      t.timestamps
    end
  end

  def self.down
    drop_table :games
  end
end
