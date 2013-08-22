class ChangeTimeslotsToIntentionAndOutcome < ActiveRecord::Migration
  def up
    rename_column :timeslots, :status, :intention
    rename_column :timeslots, :start_time, :intended_start_time
    rename_column :timeslots, :end_time, :intended_end_time
    rename_column :timeslots, :duration, :actual_duration

    add_column :timeslots, :outcome, :string
    add_column :timeslots, :actual_start_time, :datetime
    add_column :timeslots, :actual_end_time, :datetime
    add_column :timeslots, :intended_duration, :decimal, precision: 7, scale: 2
    add_column :timeslots, :comments, :text

  end

  def down
    rename_column :timeslots, :intention, :status
    rename_column :timeslots, :intended_start_time, :start_time
    rename_column :timeslots, :intended_end_time, :end_time
    rename_column :timeslots, :actual_duration, :duration

    remove_column :timeslots, :outcome
    remove_column :timeslots, :actual_start_time
    remove_column :timeslots, :actual_end_time
    remove_column :timeslots, :intended_duration
    remove_column :timeslots, :comments
  end
end
