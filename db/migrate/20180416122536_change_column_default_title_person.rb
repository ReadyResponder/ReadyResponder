class ChangeColumnDefaultTitlePerson < ActiveRecord::Migration[4.2]
  def change
    change_column_null :people, :title, false, "Unknown"
  end
end
