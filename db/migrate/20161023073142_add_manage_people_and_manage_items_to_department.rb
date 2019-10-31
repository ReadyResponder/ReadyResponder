class AddManagePeopleAndManageItemsToDepartment < ActiveRecord::Migration[4.2]
  def change
    add_column :departments, :manage_people, :boolean, default: false
    add_column :departments, :manage_items, :boolean, default: false
  end
end
