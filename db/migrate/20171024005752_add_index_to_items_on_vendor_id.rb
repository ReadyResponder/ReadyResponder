class AddIndexToItemsOnVendorId < ActiveRecord::Migration
  def change
    add_index :items, :vendor_id
  end
end
