class AddQuestions < ActiveRecord::Migration[4.2]
  def up
    create_table :questions do |t|
      t.string :prompt
      t.string :response_choices
      t.string :category
      t.string :status
      t.text :comments
      t.timestamps
    end
  end

  def down
    drop_table :questions
  end
end
