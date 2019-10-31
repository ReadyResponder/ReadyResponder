class AddConditionToItem < ActiveRecord::Migration[4.2]
  def change
    add_column :items, :condition, :string
  end
end
