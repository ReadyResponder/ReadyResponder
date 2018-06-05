class RequireMinTitleEvents < ActiveRecord::Migration
  def change
    change_column_null :events, :min_title, false, "Recruit"
  end
end
