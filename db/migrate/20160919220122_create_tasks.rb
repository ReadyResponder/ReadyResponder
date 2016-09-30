class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.references :event, index: true, foreign_key: true
      t.string :title
      t.text :description
      t.string :street
      t.string :city
      t.string :state
      t.string :zipcode
      t.float :latitude
      t.float :longitude
      t.datetime :start_time
      t.datetime :end_time

      t.timestamps null: false
    end
  end
end
