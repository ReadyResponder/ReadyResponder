class AddFieldsToDepartments < ActiveRecord::Migration[4.2]
  def change
    add_column :departments, :division1, :string
    add_column :departments, :division2, :string
  end
end
