class AddConditionToItem < ActiveRecord::Migration
  def change
    add_column :items, :condition, :string
  end
end
