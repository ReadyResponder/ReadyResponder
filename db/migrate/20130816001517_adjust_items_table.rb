class AdjustItemsTable < ActiveRecord::Migration[4.2]
def change
    add_column :items, :icsid, :string
    add_column :items, :po_number, :string
    add_column :items, :value, :decimal, :precision => 8, :scale => 2
    
    rename_column :items, :serial, :serial1
	rename_column :items, :local_serial, :serial2
	add_column :items, :serial3, :string
  end
end
