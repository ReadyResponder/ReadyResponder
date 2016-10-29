class UpdateMessagesFields < ActiveRecord::Migration
  def change
    add_column :messages, :recipient_id, :integer
  end
end
