class ChangeLocationToString < ActiveRecord::Migration
  def up
    rename_column :items, :location_id, :location
    change_column :items, :location, :string
  end

  def down
  end
end
