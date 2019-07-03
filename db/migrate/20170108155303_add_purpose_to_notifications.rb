class AddPurposeToNotifications < ActiveRecord::Migration[4.2]
  def change
    add_column :notifications, :purpose, :string
  end
end
