class AddItemTypeImageToItemTypes < ActiveRecord::Migration[4.2]
  def change
    add_column :item_types, :item_type_image, :string
  end
end
