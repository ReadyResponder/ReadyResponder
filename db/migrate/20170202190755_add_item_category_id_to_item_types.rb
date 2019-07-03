class AddItemCategoryIdToItemTypes < ActiveRecord::Migration[4.2]
  def change
    add_column :item_types , :item_category_id, :integer
  end
end
