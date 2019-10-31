class AlterTimecards < ActiveRecord::Migration[4.2]
  def change
    add_column :timecards, :error_code, :string
    add_column :timecards, :description, :string
  end
end
