class ChangeDurationColumnTypeInEvents < ActiveRecord::Migration[5.1]
  def self.up
    change_column :events, :duration, :integer
  end

  def self.down
    change_column :events, :duration, :bigint
  end
end
