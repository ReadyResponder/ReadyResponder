class AddAutoAssignToRequirements < ActiveRecord::Migration
  def change
    add_column :requirements, :auto_assign, :boolean, default: false
  end
end
