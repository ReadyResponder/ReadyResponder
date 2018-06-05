class ChangeColumnDefaultTitlePerson < ActiveRecord::Migration
  def change
    change_column_null :people, :title, false, "Unknown"
  end
end
