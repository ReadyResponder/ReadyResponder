class AddNameToUser < ActiveRecord::Migration[4.2]
  def change
    add_column :users, :firstname, :string
    add_column :users, :lastname, :string
  end
end
