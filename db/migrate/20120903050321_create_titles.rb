class CreateTitles < ActiveRecord::Migration
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
