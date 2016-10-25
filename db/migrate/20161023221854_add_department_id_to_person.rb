class AddDepartmentIdToPerson < ActiveRecord::Migration
  def change
  	remove_column :people, :department, :string
  	add_column :people, :department_id, :integer
  end
end
