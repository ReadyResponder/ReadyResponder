class FullyRemoveDefaultFromMinTitle < ActiveRecord::Migration
  def change
    change_column_default :events, :min_title, nil
  end
end
