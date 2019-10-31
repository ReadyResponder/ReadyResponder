class AddIdCodeToNotifications < ActiveRecord::Migration[4.2]
  def change
    add_column :notifications, :id_code, :string
  end
end
