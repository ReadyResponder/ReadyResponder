class ChangeTitleToNameInSkills < ActiveRecord::Migration
  def up
    rename_column :skills, :title, :name
    rename_column :titles, :title, :name
    rename_column :courses, :title, :name
  end

  def down
    rename_column :skills, :name, :title
    rename_column :courses, :name, :title
    rename_column :titles, :name, :title
  end
end
