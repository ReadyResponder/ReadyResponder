class FullyRemoveDefaultFromMinTitle < ActiveRecord::Migration
  def change
    change_column_default :events, :min_title, :string
  end
end
