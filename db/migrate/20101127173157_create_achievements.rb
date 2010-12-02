class CreateAchievements < ActiveRecord::Migration
  def self.up
    create_table :achievements do |t|
      t.string   :achievement_id
      t.integer  :category_id
      t.integer  :points
      t.string   :name
      t.string   :description
      t.integer :is_active
    end
  end

  def self.down
    
  end
end
