class AddCostToRepairs < ActiveRecord::Migration
  def change
    add_column :repairs, :cost, :decimal, :precision => 8, :scale => 2
  end
end
