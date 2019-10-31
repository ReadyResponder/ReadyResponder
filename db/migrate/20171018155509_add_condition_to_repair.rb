class AddConditionToRepair < ActiveRecord::Migration[4.2]
  def change
    add_column :repairs, :condition, :string
  end
end
