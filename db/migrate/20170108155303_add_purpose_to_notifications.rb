class AddPurposeToNotifications < ActiveRecord::Migration
  def change
    add_column :notifications, :purpose, :string
  end
end
