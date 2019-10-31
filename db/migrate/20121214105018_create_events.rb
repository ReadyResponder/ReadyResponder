class CreateEvents < ActiveRecord::Migration[4.2]
  def change
    create_table :events do |t|
      t.integer :course_id
      t.string :instructor
      t.string :location
      t.string :description
      t.datetime :start_date
      t.datetime :end_date
      t.integer :duration
      t.string :category
      t.string :status

      t.timestamps
    end
  end
end
