class AddTitleOrderToPeople < ActiveRecord::Migration
  def change
    add_column :people, :title_order, :integer
  end
end
