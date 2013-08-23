class AddTitleToEvents < ActiveRecord::Migration
  def change
    add_column :events, :title, :string
    add_column :events, :comments, :text
  end
end
