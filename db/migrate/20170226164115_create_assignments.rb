class CreateAssignments < ActiveRecord::Migration[4.2]
  def change
    create_table :assignments do |t|
      t.belongs_to :person, index: true, foreign_key: true
      t.belongs_to :requirement, index: true, foreign_key: true
      t.datetime :start_time
      t.datetime :end_time
      t.string :status
      t.decimal :duration, :precision => 7, :scale => 2

      t.timestamps null: false
    end
  end
end
