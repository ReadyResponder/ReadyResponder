class AddItemTypeIdToItem < ActiveRecord::Migration[4.2]
  def change
    add_column :items, :item_type_id, :integer
  end
end
