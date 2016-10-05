class CreateDepartments < ActiveRecord::Migration
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
