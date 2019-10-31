class RemoveDepartmentIdFromItemCategories < ActiveRecord::Migration[4.2]
  def change
    remove_column :item_categories, :department_id
  end
end
