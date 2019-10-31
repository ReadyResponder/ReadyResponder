class AddMinTitleToEvent < ActiveRecord::Migration[4.2]
  def change
    add_column :events, :min_title, :string
  end
end
