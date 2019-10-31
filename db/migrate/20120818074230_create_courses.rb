class CreateCourses < ActiveRecord::Migration[4.2]
  def change
    create_table :courses do |t|
      t.string :title
      t.string :status
      t.text :description
      t.text :comments
      t.string :category
      t.integer :duration
      t.integer :term
      t.string :required_for

      t.timestamps
    end
  end
end
