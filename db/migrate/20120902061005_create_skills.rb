class CreateSkills < ActiveRecord::Migration[4.2]
  def change
    create_table :skills do |t|
      t.string :title
      t.string :status
      t.boolean :required_for_pd
      t.boolean :required_for_cert
      t.boolean :required_for_sar

      t.timestamps
    end
  end
end
