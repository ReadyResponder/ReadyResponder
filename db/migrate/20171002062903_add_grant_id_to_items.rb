class AddGrantIdToItems < ActiveRecord::Migration[4.2]
  def change
    add_column :items, :grant_id, :integer
  end
end
