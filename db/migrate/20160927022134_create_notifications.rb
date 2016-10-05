class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      t.belongs_to :event, index: true, foreign_key: true
      t.string :status
      t.string :subject
      t.string :body
      t.integer :hours_to_try
      t.integer :minutes_interval
      t.integer :attempts_before_escalation
      t.datetime :start_at
      t.datetime :started_at
      t.string :channels

      t.timestamps null: false
    end
  end
end
