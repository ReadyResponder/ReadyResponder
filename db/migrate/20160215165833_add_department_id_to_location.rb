class AddDepartmentIdToLocation < ActiveRecord::Migration
  def change
    unless column_exists? :locations, :department_id
      add_column :locations, :department_id, :integer
    end
  end
end
