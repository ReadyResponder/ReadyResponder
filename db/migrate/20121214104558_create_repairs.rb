class CreateRepairs < ActiveRecord::Migration[4.2]
  def change
    create_table :repairs do |t|
      t.integer :item_id
      t.integer :user_id
      t.string :person_id
      t.string :category
      t.date :service_date
      t.string :status
      t.string :description
      t.string :comments

      t.timestamps
    end
  end
end
