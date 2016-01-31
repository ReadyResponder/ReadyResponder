class ChangeLocationToString < ActiveRecord::Migration
  def up
    rename_column :items, :location_id, :location
    change_column :items, :location, :string
  end

  # Warning: destructive!
  # Destroys data because no reason to expect strings can be mapped to location IDs.
  def down
    remove_column :items, :location
    add_column :items, :location_id, :integer
  end
end
