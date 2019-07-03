class CreateAvailabilities < ActiveRecord::Migration[4.2]
  def change
    create_table :availabilities do |t|
      t.datetime :start_time
      t.datetime :end_time
      t.string :status
      t.text :description

      t.timestamps null: false
    end
    add_reference :availabilities, :person, index: true
  end
end
