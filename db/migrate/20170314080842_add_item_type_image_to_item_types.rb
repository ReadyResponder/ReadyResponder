class AddItemTypeImageToItemTypes < ActiveRecord::Migration
  def change
    add_column :item_types, :item_type_image, :string
  end
end
