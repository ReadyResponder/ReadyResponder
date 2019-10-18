class ChangePersonTitleAsOptional < ActiveRecord::Migration[5.2]
  def up
    change_column_null :people, :title, true
  end

  def down
    change_column_null :people, :title, false
  end
end
