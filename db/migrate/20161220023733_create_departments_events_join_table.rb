class CreateDepartmentsEventsJoinTable < ActiveRecord::Migration
  def change
    create_join_table :departments, :events do |t|
      t.index [:department_id, :event_id]
      t.index [:event_id, :department_id]
    end
  end
end
