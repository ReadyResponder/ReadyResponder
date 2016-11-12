class RenameCommentsFieldOnPerson < ActiveRecord::Migration
  def change
    rename_column :people, :comments, :old_comments
  end
end
