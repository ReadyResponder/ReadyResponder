class AddAutoAssignToRequirements < ActiveRecord::Migration[4.2]
  def change
    add_column :requirements, :auto_assign, :boolean, default: false
  end
end
