class AddGrantIdToItems < ActiveRecord::Migration
  def change
    add_column :items, :grant_id, :integer
    add_index :items, :grant_id
  end
end
