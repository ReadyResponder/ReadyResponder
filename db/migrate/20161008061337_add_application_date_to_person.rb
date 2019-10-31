class AddApplicationDateToPerson < ActiveRecord::Migration[4.2]
  def change
    add_column :people, :application_date, :date
  end
end
