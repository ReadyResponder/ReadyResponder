class CreateActivities < ActiveRecord::Migration[4.2]
  def change
    create_table :activities do |t|
      t.string :content
      t.string :author
      t.integer :loggable_id
      t.string :loggable_type

      t.timestamps
    end
  end
end
