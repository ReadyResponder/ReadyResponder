class ChangeDurationFromIntegerInEvents < ActiveRecord::Migration[4.2]
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