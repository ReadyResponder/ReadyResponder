class AddFloorToLocations < ActiveRecord::Migration[4.2]
  def change
    add_column :locations, :floor, :string
    add_column :locations, :container, :string
    add_column :locations, :street, :string
    add_column :locations, :city, :string
    add_column :locations, :state, :string
    add_column :locations, :zipcode, :string
  end
end
