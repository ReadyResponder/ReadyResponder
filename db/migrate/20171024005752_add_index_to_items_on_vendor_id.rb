class AddIndexToItemsOnVendorId < ActiveRecord::Migration[4.2]
  def change
    add_index :items, :vendor_id
  end
end
