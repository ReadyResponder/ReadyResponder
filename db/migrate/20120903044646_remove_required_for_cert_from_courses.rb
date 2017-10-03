class RemoveRequiredForCertFromCourses < ActiveRecord::Migration[4.2]
  def up
    remove_column :courses, :required_for_pd
    remove_column :courses, :required_for_cert
    remove_column :courses, :required_for_sar
  end
  
  def down
    add_column :courses, :required_for_pd, :string
    add_column :courses, :required_for_cert, :string
    add_column :courses, :required_for_sar, :string
  end
end
