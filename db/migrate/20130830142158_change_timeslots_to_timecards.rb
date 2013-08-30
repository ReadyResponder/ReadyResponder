class ChangeTimeslotsToTimecards < ActiveRecord::Migration
  def up
    rename_table :timeslots, :timecards
  end

  def down
    rename_table :timecards, :timeslots
  end
end
