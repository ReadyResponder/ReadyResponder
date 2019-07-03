class AddStatusToTasks < ActiveRecord::Migration[4.2]
  def change
       add_column :tasks, :status, :string
  end
end
