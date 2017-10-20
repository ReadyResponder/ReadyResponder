class RemoveDefaultFromMinTitle < ActiveRecord::Migration
  def change
    change_column_default :events, :min_title, ""
  end
end
