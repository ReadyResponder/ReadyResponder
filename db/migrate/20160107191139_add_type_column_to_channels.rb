class AddTypeColumnToChannels < ActiveRecord::Migration[4.2]
  def change
    add_column :channels, :type, :string
  end
end
