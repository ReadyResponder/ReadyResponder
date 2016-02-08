class CorrectFieldNamesToTimeNotDate < ActiveRecord::Migration
  def up
    rename_column :events, :start_date, :start_time
    rename_column :events, :end_date, :end_time
  end

  def down
    rename_column :events, :start_time, :start_date
    rename_column :events, :end_time, :end_date
  end
end
