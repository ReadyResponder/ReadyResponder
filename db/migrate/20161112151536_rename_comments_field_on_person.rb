class RenameCommentsFieldOnPerson < ActiveRecord::Migration[4.2]
  def change
    rename_column :people, :comments, :old_comments
  end
end
