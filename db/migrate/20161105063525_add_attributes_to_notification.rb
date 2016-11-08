class AddAttributesToNotification < ActiveRecord::Migration
  def change
    add_column :notifications, :subject, :string
    add_column :notifications, :body, :text
  end
end
