class RequireMinTitleEvents < ActiveRecord::Migration[4.2]
  def change
    change_column_null :events, :min_title, false, "Recruit"
  end
end
