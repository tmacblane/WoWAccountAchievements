class CreateCategoryTypes < ActiveRecord::Migration
  def self.up
    create_table :category_types do |t|
      t.integer :category_type_id
      t.string  :description
    end
  end

  def self.down
  end
end