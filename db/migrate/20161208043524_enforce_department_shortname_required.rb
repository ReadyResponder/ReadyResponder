class EnforceDepartmentShortnameRequired < ActiveRecord::Migration[4.2]
  def change
    
    # use raw sql to update any departments with null shortname
    Department.where(shortname: nil).update_all("shortname = name")
    
    # at this point, there may still be departments with nil name and shortname
    Department.where(shortname: nil).each_with_index {|d, i| d.update_columns(shortname: "dept_#{i}")}
    
    # finally, it should be safe to set shortname to null: false
    change_column :departments, :shortname, :string, null: false
  end
end
