class CreateNotifications < ActiveRecord::Migration[4.2]
  def change
    create_table :notifications do |t|
      t.belongs_to :event, index: true, foreign_key: true
      t.references :author, references: :users
      t.string :status
      t.integer :time_to_live
      t.integer :interval
      t.integer :iterations_to_escalation
      t.datetime :scheduled_start_time
      t.datetime :start_time
      t.text :channels
      t.text :groups
      t.text :departments
      t.text :divisions

      t.timestamps null: false
    end
  end
end
