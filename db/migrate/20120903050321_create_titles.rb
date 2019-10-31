class CreateTitles < ActiveRecord::Migration[4.2]
  def change
    create_table :titles do |t|
      t.string :title
      t.string :status
      t.string :description
      t.text :comments

      t.timestamps
    end
  end
end
