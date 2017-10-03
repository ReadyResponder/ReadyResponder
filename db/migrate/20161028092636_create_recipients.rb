class CreateRecipients < ActiveRecord::Migration[4.2]
  def change
    create_table :recipients do |t|
      t.integer :notification_id
      t.integer :person_id
      t.text :status
      t.text :response_channel
      t.datetime :response_time

      t.timestamps null: false
    end
  end
end
