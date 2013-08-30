class AlterTimecards < ActiveRecord::Migration
  def change
    add_column :timecards, :error_code, :string
    add_column :timecards, :description, :string
  end
end
