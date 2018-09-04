class CreateVendors < ActiveRecord::Migration[4.2]
  def change
    create_table :vendors do |t|
      t.string :name
      t.string :street
      t.string :city
      t.string :state
      t.string :zipcode
      t.string :status
      t.text :comments
      t.timestamps
    end
  end
end
