class AddTypeToChannels < ActiveRecord::Migration
  def change
    add_column :channels, :type, :string
  end
end
