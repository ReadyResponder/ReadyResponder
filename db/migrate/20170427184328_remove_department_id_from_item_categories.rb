class RemoveDepartmentIdFromItemCategories < ActiveRecord::Migration
  def change
    remove_column :item_categories, :department_id
  end
end
