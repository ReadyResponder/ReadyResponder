class CreateResourcetypes < ActiveRecord::Migration
  def change
    create_table :resourcetypes do |t|
      t.string :name
      t.string :femakind
      t.string :femacode
      t.string :status
      t.text :description

      t.timestamps
    end
  end
end
