class AddItemImageToItem < ActiveRecord::Migration
  def change
    add_column :items, :item_image, :string
  end
end
