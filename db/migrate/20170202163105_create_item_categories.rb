class CreateItemCategories < ActiveRecord::Migration[4.2]
  def change
    create_table :item_categories do |t|
      t.string :name
      t.string :status
      t.string :description
      t.belongs_to :department, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
