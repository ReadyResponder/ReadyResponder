class RequireTitlePerson < ActiveRecord::Migration
  def change
    change_column_null :people, :title, false, "Recruit"
    change_column_null :people, :title_order, false, 30
  end
end
