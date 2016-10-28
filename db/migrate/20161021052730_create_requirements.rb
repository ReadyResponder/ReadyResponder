class CreateRequirements < ActiveRecord::Migration
  def change
    create_table :requirements do |t|
      t.references :task, index: true, foreign_key: true
      t.references :skill, index: true, foreign_key: true
      t.references :title, index: true, foreign_key: true
      t.integer :priority
      t.integer :minimum_people
      t.integer :maximum_people
      t.integer :desired_people
      t.boolean :floating
      t.boolean :optional

      t.timestamps null: false
    end
  end
end
