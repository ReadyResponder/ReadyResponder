class CreateInspectionQuestions < ActiveRecord::Migration[4.2]
  def change
    create_table :inspection_questions do |t|
      t.references :inspection
      t.references :question
      t.string :prompt
      t.string :response
      t.text :comments

      t.timestamps
    end
    add_index :inspection_questions, :inspection_id
    add_index :inspection_questions, :question_id
  end
end
