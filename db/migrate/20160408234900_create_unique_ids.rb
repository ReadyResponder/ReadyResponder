class CreateUniqueIds < ActiveRecord::Migration
  def change
    create_table :unique_ids do |t|
      t.belongs_to :item
      t.string :status
      t.string :category
      t.string :value

      t.timestamps
    end
    add_index :unique_ids, :item_id
  end
end
