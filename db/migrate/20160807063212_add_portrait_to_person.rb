class AddPortraitToPerson < ActiveRecord::Migration
  def change
    add_column :people, :portrait, :string
  end
end
