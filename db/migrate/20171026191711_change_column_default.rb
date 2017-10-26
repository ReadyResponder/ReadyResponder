class ChangeColumnDefault < ActiveRecord::Migration
  def up
    change_column_default :tasks, :status, 'Active'
  end

  def down
    change_column_default :tasks, :status, nil
  end
end
