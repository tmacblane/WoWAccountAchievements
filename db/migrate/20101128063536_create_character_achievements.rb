class CreateCharacterAchievements < ActiveRecord::Migration
  def self.up
    create_table :character_achievements do |t|
      t.integer :character_id
      t.integer :achievement_id
      t.integer :is_complete
    end
  end

  def self.down
    drop_table :character_achievements
  end
end
