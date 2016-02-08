class AddLocationIdToItem < ActiveRecord::Migration
  def change
    add_column :items, :location_id, :integer
    remove_column :items, :location
  end
end
