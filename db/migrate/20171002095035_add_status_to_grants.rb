class AddStatusToGrants < ActiveRecord::Migration[4.2]
  def change
    add_column :grants, :status, :string
  end
end
