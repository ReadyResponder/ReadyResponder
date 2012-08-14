class AddDurationToPeople < ActiveRecord::Migration
  def change
     add_column :people, :duration, :integer
  end
end
