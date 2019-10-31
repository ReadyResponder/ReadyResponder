class CreateMoves < ActiveRecord::Migration[4.2]
  def change
    create_table :moves do |t|
      t.integer :item_id
      t.integer :locatable_id
      t.string :locatable_type
      t.string :comments
      t.string :reason

      t.timestamps
    end
  end
end
