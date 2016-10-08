class AddApplicationDateToPerson < ActiveRecord::Migration
  def change
    add_column :people, :application_date, :date
  end
end
