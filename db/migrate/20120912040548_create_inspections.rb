class CreateInspections < ActiveRecord::Migration
  def change
    create_table :inspections do |t|
      t.integer :person_id
      t.datetime :inspection_date

      t.timestamps
    end
  end
end
