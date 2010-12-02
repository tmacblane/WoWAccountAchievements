class CreateRealms < ActiveRecord::Migration
  def self.up
    create_table :realms do |t|
      t.string :realm_local
      t.string :realm_name
    end
  end

  def self.down
    drop_table :realms
  end
end
