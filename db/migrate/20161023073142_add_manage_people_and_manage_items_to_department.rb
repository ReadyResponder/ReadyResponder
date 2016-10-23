class AddManagePeopleAndManageItemsToDepartment < ActiveRecord::Migration
  def change
    add_column :departments, :manage_people, :boolean, default: false
    add_column :departments, :manage_items, :boolean, default: false
  end
end
