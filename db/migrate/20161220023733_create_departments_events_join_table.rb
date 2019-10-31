class CreateDepartmentsEventsJoinTable < ActiveRecord::Migration[4.2]
  def change
    create_join_table :departments, :events do |t|
      t.index [:department_id, :event_id]
      t.index [:event_id, :department_id]
    end
  end
end
