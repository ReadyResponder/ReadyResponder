class AddItemCategoryIdToItemTypes < ActiveRecord::Migration
  def change
    add_column :item_types , :item_category_id, :integer
  end
end
