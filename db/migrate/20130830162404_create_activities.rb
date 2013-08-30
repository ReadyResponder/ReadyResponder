class CreateActivities < ActiveRecord::Migration
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
