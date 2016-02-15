class CreateResourceTypes < ActiveRecord::Migration
  def change
    create_table :resource_types do |t|
      t.string :name
      t.string :status
      t.text :description
      t.string :fema_code
      t.string :fema_kind

      t.timestamps
    end
  end
end
