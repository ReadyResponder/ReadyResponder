class AddOrderToTitles < ActiveRecord::Migration
  def change
    add_column :titles, :order, :integer
  end
end
