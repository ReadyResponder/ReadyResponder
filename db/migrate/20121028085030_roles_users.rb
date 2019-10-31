class RolesUsers < ActiveRecord::Migration[4.2]
  def change
      create_table :roles_users, :id => false do |t|
	t.integer :role_id
	t.integer :user_id
      end
    
      add_index :roles_users, [:role_id, :user_id]
  end
end
