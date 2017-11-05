class AddConditionToRepair < ActiveRecord::Migration
  def change
    add_column :repairs, :condition, :string
  end
end
