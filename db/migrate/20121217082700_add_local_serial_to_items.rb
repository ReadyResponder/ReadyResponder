class AddLocalSerialToItems < ActiveRecord::Migration[4.2]
  def change
    add_column :items, :local_serial, :string
  end
end
