class AddIdCodeToNotifications < ActiveRecord::Migration
  def change
    add_column :notifications, :id_code, :string
  end
end
