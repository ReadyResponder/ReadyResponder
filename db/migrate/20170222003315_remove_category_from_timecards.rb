class RemoveCategoryFromTimecards < ActiveRecord::Migration
  def change
    remove_column :timecards, :category
  end
end
