class CreateGrants < ActiveRecord::Migration
  def change
    create_table :grants do |t|
      t.string :name
      t.text :description
      t.date :start_date
      t.date :end_date

      t.timestamps null: false
    end
  end
end
