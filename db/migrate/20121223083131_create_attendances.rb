class CreateAttendances < ActiveRecord::Migration[4.2]
  def change
    create_table :attendances do |t|
      t.integer :person_id
      t.integer :event_id
      t.string :category
      t.datetime :est_start_time
      t.datetime :start_time
      t.datetime :est_end_time
      t.datetime :end_time
      t.decimal :duration,    :precision => 7, :scale => 2

      t.timestamps
    end
    add_index :attendances, :person_id
    add_index :attendances, :event_id
  end
end
