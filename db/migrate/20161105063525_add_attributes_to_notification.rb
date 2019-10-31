class AddAttributesToNotification < ActiveRecord::Migration[4.2]
  def change
    unless column_exists? :notifications, :subject
      add_column :notifications, :subject, :string
    end
    unless column_exists? :notifications, :body
      add_column :notifications, :body, :text
    end
    unless column_exists? :notifications, :start_time
      add_column :notifications, :start_time, :datetime
    end
  end
end
