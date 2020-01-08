class AddDepartmentIdToLocation < ActiveRecord::Migration[4.2]
  def change
    unless column_exists? :locations, :department_id
      add_column :locations, :department_id, :integer
    end
  end
end
