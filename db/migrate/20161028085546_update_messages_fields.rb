class UpdateMessagesFields < ActiveRecord::Migration[4.2]
  def change
    add_column :messages, :recipient_id, :integer
  end
end
