class AddMinTitleToEvent < ActiveRecord::Migration
  def change
    add_column :events, :min_title, :string
  end
end
