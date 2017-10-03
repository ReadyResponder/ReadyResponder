class CreateRoles < ActiveRecord::Migration[4.2]
  def change
    create_table :roles do |t|
      t.string :name

      t.timestamps
    end
    add_index :roles, :name
  end
end
