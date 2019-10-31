class AddLocationToTasks < ActiveRecord::Migration[4.2]
  def change
    add_column :tasks, :location, :string
  end
end
