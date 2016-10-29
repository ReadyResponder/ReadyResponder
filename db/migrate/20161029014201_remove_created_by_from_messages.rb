class RemoveCreatedByFromMessages < ActiveRecord::Migration
  def change
    remove_column :messages, :created_by, :integer
  end
end
