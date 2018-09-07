class RequireStartEndTimeAssignments < ActiveRecord::Migration[4.2]
  def change
    change_column_null :assignments, :start_time, false
    change_column_null :assignments, :end_time, false
  end
end
