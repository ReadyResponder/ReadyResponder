class AddTableSkillsTitles < ActiveRecord::Migration
  def change
      create_table :skills_titles, :id => false do |t|
	t.integer :skill_id
	t.integer :title_id
      end
    
      add_index :skills_titles, [:skill_id, :title_id]
  end

end
