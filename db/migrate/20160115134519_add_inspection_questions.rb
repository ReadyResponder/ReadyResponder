class AddInspectionQuestions < ActiveRecord::Migration
  def up
    create_table :inspectionquestions do |t|
      t.integer :inspection_id
      t.integer :question_id
      t.string :question
      t.string :response
      t.text :comments
      t.timestamps
    end
    add_index :inspectionquestions, :inspection_id
  end

  def down
    drop_table :inspectionquestions
  end
end
