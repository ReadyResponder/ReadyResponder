class AddMugshotToPeople < ActiveRecord::Migration
  def change
    add_column :people, :mugshot, :string
  end
end
