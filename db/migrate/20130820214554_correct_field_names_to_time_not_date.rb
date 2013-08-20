class CorrectFieldNamesToTimeNotDate < ActiveRecord::Migration
  def up
    rename_column :events, :start_date, :start_time
    rename_column :events, :end_date, :end_time
    rename_column :inspections, :inspection_date, :inspection_time
  end

  def down
    rename_column :events, :start_time, :start_date
    rename_column :events, :end_time, :end_date
    rename_column :inspections, :inspection_time, :inspection_date
  end
end
