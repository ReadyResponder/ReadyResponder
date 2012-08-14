class CreateCerts < ActiveRecord::Migration
  def change
    create_table :certs do |t|
      t.integer :person_id
      t.integer :course_id
      t.integer :instructor_id  #this also points into the person table
      t.string :status
      t.string :category
      t.string :level
      t.string :id_number
      t.date :date_issued
      t.date :date_expires
      t.text :comments
      
      #these are like the timestamps
      t.integer  "updated_by"
      t.integer  "created_by"

      t.timestamps
    end
  end
end
