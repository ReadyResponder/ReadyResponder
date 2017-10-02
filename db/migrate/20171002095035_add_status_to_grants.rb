class AddStatusToGrants < ActiveRecord::Migration
  def change
    add_column :grants, :status, :string
  end
end
