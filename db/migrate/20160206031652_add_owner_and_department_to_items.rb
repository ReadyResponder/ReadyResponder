class AddOwnerAndDepartmentToItems < ActiveRecord::Migration
  def change
    add_column :items, :owner_id, :integer, index: true
    add_column :items, :department_id, :integer, index: true
    remove_column :items, :person_id
  end
end
