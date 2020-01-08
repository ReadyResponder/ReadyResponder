class ChangeChannelsFieldOnMessages < ActiveRecord::Migration[4.2]
  def change
    remove_column :messages, :channels, :string
    add_column :messages, :channel_id, :integer
  end
end
