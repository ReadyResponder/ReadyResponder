class AddTablePeopleTitles < ActiveRecord::Migration[4.2]
  def change
    create_table :people_titles, :id => false do |t|
      t.integer :person_id
      t.integer :title_id
    end
    
      add_index :people_titles, [:person_id, :title_id]
  end

end
