class AddItemviewToItem < ActiveRecord::Migration
  def change
    add_column :items, :itemview, :string
  end
end
