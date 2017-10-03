class CreateDepartments < ActiveRecord::Migration[4.2]
  def change
    create_table :departments do |t|
      t.string :name
      t.string :shortname
      t.string :status
      t.integer :contact_id
      t.text :description

      t.timestamps
    end
  end
end
