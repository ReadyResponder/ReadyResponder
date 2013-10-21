class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.string :subject
      t.string :status
      t.string :body
      t.string :channels
      t.datetime :sent_at
      t.integer :created_by

      t.timestamps
    end
  end
end
