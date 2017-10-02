class AddGrantIdToItems < ActiveRecord::Migration
  def change
    add_column :items, :grant_id, :integer
  end
end
