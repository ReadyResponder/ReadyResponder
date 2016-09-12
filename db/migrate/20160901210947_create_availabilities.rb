class CreateAvailabilities < ActiveRecord::Migration
  def change
    create_table :availabilities do |t|
      t.datetime :start_time
      t.datetime :end_time
      t.string :status
      t.text :description

      t.timestamps null: false
    end
    add_reference :availabilities, :person, index: true
    add_reference :availabilities, :event, index: true
  end
end
