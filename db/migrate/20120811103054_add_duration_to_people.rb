class AddDurationToPeople < ActiveRecord::Migration[4.2]
  def change
     add_column :people, :duration, :integer
  end
end
