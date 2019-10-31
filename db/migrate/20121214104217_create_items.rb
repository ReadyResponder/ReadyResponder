class CreateItems < ActiveRecord::Migration[4.2]
  def change
    create_table :items do |t|
      t.integer :location_id
      t.string :name
      t.string :description
      t.string :source
      t.string :category
      t.string :model
      t.string :serial
      t.integer :owner_id
      t.date :purchase_date
      t.float :purchase_amt
      t.date :sell_date
      t.float :sell_amt
      t.string :status

      t.timestamps
    end
  end
end
