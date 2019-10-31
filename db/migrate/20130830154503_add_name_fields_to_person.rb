class AddNameFieldsToPerson < ActiveRecord::Migration[4.2]
  def change
    add_column :people, :error_code, :string
    add_column :people, :prefix_name, :string
    add_column :people, :middlename, :string
    add_column :people, :suffix_name, :string
    add_column :people, :nickname, :string
  end
end
