class CreateItemTypes < ActiveRecord::Migration[4.2]
  def change
    create_table :item_types do |t|
      t.string :name
      t.string :status
      t.string :is_groupable
      t.string :is_a_group
      t.integer :parent_id

      t.timestamps
    end
  end
end
