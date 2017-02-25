class CorrectTimecardSchema < ActiveRecord::Migration
  def change
    add_column :timecards, :status, :string

    rename_column :timecards, :intended_duration, :duration
    rename_column :timecards, :actual_start_time, :start_time
    rename_column :timecards, :actual_end_time, :end_time

    remove_column :timecards, :event_id
    remove_column :timecards, :intention
    remove_column :timecards, :intended_start_time
    remove_column :timecards, :intended_end_time
    remove_column :timecards, :actual_duration
    remove_column :timecards, :outcome
  end
end
