class AddTitleToDepartments < ActiveRecord::Migration
  def change
    add_reference :departments, :title, index: true, foreign_key: true
  end
end
