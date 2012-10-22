class AddStatusToInspections < ActiveRecord::Migration
  def change
      add_column :inspections, :status, :string
  end
end
