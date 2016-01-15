class AddQuestions < ActiveRecord::Migration
  def up
    create_table :questions do |t|
      t.string :question
      t.string :responsechoices
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
