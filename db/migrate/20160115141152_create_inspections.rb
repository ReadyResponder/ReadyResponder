class CreateInspections < ActiveRecord::Migration
  def up
    drop_table :inspections
    create_table :inspections do |t|
      t.integer :item_id
      t.integer :person_id  # Inspector
      t.datetime :inspection_date
      t.integer :mileage
      t.string :repair_needed
      t.string :status
      t.text :comments
      t.string :category

      t.timestamps
    end
    add_index :inspections, :item_id
  end

  def down
    drop_table :inspections
  end
end
