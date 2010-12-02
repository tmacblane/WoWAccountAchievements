class SetCategories < ActiveRecord::Migration
  def self.up
    #Achievement Categories
    Categories.create(:category_type_id => 0, :category_id => 92, :category_name => "General")
    Categories.create(:category_type_id => 0, :category_id => 96, :category_name => "Quests")
    Categories.create(:category_type_id => 0, :category_id => 97, :category_name => "Exploration")
    Categories.create(:category_type_id => 0, :category_id => 95, :category_name => "Player vs Player")
    Categories.create(:category_type_id => 0, :category_id => 168, :category_name => "Dungeons and Raids")
    Categories.create(:category_type_id => 0, :category_id => 169, :category_name => "Professions")
    Categories.create(:category_type_id => 0, :category_id => 201, :category_name => "Reputations")
    Categories.create(:category_type_id => 0, :category_id => 155, :category_name => "World Events")
    Categories.create(:category_type_id => 0, :category_id => 81, :category_name => "Feats of Strength")

    #Statistics Categories
    Categories.create(:category_type_id => 1, :category_id => 128, :category_name => "Kills")
    Categories.create(:category_type_id => 1, :category_id => 141, :category_name => "Combat")
    Categories.create(:category_type_id => 1, :category_id => 130, :category_name => "Character")
    Categories.create(:category_type_id => 1, :category_id => 131, :category_name => "Social")
    Categories.create(:category_type_id => 1, :category_id => 132, :category_name => "Skills")
    Categories.create(:category_type_id => 1, :category_id => 133, :category_name => "Quests")
    Categories.create(:category_type_id => 1, :category_id => 122, :category_name => "Deaths")
    Categories.create(:category_type_id => 1, :category_id => 134, :category_name => "Travel")
    Categories.create(:category_type_id => 1, :category_id => 14807, :category_name => "Dungeons and Raids")
    Categories.create(:category_type_id => 1, :category_id => 21, :category_name => "Player vs. Player")
  end

  def self.down
  end
end
