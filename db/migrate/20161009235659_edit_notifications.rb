class EditNotifications < ActiveRecord::Migration
  def change
    remove_column :notifications, :subject, :string
    remove_column :notifications, :body, :string
    add_column :notifications, :groups, :string
    add_column :notifications, :author_id, :integer

    add_foreign_key :notifications, :users, column: :author_id
  end
end
