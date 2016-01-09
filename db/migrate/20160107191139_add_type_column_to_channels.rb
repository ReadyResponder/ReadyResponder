class AddTypeColumnToChannels < ActiveRecord::Migration
  def change
    add_column :channels, :type, :string
  end
end
