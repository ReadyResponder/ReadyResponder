class RemoveSerialNumbersFromItems < ActiveRecord::Migration
  def change
    remove_column :items, :serial1, :integer
    remove_column :items, :serial2, :integer
    remove_column :items, :serial3, :integer
  end
end
