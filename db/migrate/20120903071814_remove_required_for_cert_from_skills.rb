class RemoveRequiredForCertFromSkills < ActiveRecord::Migration[4.2]
  def up
    remove_column :skills, :required_for_pd
    remove_column :skills, :required_for_cert
    remove_column :skills, :required_for_sar
  end
  
  def down
    add_column :skills, :required_for_pd, :string
    add_column :skills, :required_for_cert, :string
    add_column :skills, :required_for_sar, :string
  end
end
