class CreateChannels < ActiveRecord::Migration
  def change
    create_table :channels do |t|
      t.integer :person_id
      t.string :name
      t.string :status
      t.string :content
      t.integer :priority
      t.string :category
      t.string :carrier
      t.datetime :last_verified
      t.string :usage

      t.timestamps
    end
    add_index :channels, :person_id
    add_index :channels, :priority
    add_index :channels, :category
  end
end
