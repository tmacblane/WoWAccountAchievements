class SetCategoryTypes < ActiveRecord::Migration
  def self.up
    CategoryType.create(:category_type_id => 0, :description => "Achievements")
    CategoryType.create(:category_type_id => 1, :description => "Statistics")
  end

  def self.down
  end
end
