class CreateCategories < ActiveRecord::Migration
  def self.up
    create_table :categories do |t|
      t.integer :category_type_id
      t.integer :category_id
      t.string  :category_name
    end
  end

  def self.down

  end
end
