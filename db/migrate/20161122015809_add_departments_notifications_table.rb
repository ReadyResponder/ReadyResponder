class AddDepartmentsNotificationsTable < ActiveRecord::Migration[4.2]
  def change
    unless table_exists? :departments_notifications
      create_table :departments_notifications, :id => false do |t|
        t.references :department, :notification
      end
    end

    unless index_exists? :departments_notifications_index,
                        [:department_id, :notification_id]
      add_index :departments_notifications,
               [:department_id, :notification_id],
               name: 'departments_notifications_index'
    end
  end
end
