class CreateCharacters < ActiveRecord::Migration
  def self.up
    create_table :characters do |t|
      t.string :account_id
      t.string :character_name
      t.string :realm_id
    end
  end

  def self.down
    drop_table :characters
  end
end
