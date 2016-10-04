class AddFieldsToDepartments < ActiveRecord::Migration
  def change
    add_column :departments, :division1, :string
    add_column :departments, :division2, :string
  end
end
