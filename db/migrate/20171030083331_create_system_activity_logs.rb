class CreateSystemActivityLogs < ActiveRecord::Migration
  def change
    create_table :system_activity_logs do |t|
      t.references :user
      t.text :message, null: false
      t.string :category, null: false

      t.timestamps null: false
    end
  end
end
