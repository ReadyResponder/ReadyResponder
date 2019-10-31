class AddQtyToItems < ActiveRecord::Migration[4.2]
  def change
    add_column :items, :qty, :integer
  end
end
