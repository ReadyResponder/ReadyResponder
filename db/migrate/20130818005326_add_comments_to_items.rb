class AddCommentsToItems < ActiveRecord::Migration
  def change
    add_column :items, :brand, :string
    add_column :items, :stock_number, :string
    add_column :items, :comments, :text
  end
end
