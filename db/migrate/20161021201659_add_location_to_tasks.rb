class AddLocationToTasks < ActiveRecord::Migration
  def change
    add_column :tasks, :location, :string
  end
end
