class RemoveChannelTypeFromChannels < ActiveRecord::Migration
  def up
    remove_column :channels, :channel_type
  end

  def down
    add_column :channels, :channel_type, :string
  end
end
