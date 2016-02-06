class AddResourcetypeIdToItem < ActiveRecord::Migration
  def change
    add_column :items, :resourcetype_id, :integer
  end
end
