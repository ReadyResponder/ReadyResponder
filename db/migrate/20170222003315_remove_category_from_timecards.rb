class RemoveCategoryFromTimecards < ActiveRecord::Migration[4.2]
  def change
    remove_column :timecards, :category
  end
end
