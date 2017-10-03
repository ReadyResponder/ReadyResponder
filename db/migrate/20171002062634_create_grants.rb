class CreateGrants < ActiveRecord::Migration
  def change
    create_table :grants do |t|
      t.string :name
      t.text :description
      t.datetime :start_date
      t.datetime :end_date
    end
  end
end
