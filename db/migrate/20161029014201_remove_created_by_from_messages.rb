class RemoveCreatedByFromMessages < ActiveRecord::Migration[4.2]
  def change
    remove_column :messages, :created_by, :integer
  end
end
