class AddDescriptionToItemType < ActiveRecord::Migration
  def change
    add_column :item_types , :description, :string
  end
end
