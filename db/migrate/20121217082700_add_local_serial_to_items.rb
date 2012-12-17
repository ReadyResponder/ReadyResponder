class AddLocalSerialToItems < ActiveRecord::Migration
  def change
    add_column :items, :local_serial, :string
  end
end
