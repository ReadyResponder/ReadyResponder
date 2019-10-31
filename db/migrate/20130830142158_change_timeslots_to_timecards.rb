class ChangeTimeslotsToTimecards < ActiveRecord::Migration[4.2]
  def up
    rename_table :timeslots, :timecards
  end

  def down
    rename_table :timecards, :timeslots
  end
end
