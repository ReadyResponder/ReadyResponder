class AddTitleOrderToPeople < ActiveRecord::Migration[4.2]
  def change
    add_column :people, :title_order, :integer
  end
end
