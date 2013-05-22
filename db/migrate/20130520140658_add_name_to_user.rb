class AddNameToUser < ActiveRecord::Migration
  def change
    add_column :users, :firstname, :string
    add_column :users, :lastname, :string
  end
end
