class AddItemImageToItem < ActiveRecord::Migration[4.2]
  def change
    add_column :items, :item_image, :string
  end
end
