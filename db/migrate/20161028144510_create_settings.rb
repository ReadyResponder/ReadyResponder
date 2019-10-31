class CreateSettings < ActiveRecord::Migration[4.2]
  def change
    create_table :settings do |t|
      t.string  "name"
      t.string  "description"
      t.string  "key"
      t.string  "value"
      t.string  "category"
      t.string  "status"
      t.boolean "required", default: false
      t.timestamps null: false
    end
  end
end
