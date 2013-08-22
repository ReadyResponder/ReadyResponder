class ChangeDurationFromIntegerInEvents < ActiveRecord::Migration
  def up
    change_table :events do |t|
      t.change :duration, :decimal, precision: 7, scale: 2
    end
  end

  def down
    change_table :events do |t|
      t.change :duration, :integer
    end
  end
end