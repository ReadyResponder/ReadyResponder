class AddResourceTypeIdToItem < ActiveRecord::Migration
  def up
    if column_exists? :items, :resourcetype_id
      remove_column :items, :resourcetype_id
    end
    unless column_exists? :items, :resource_type_id
      add_column :items, :resource_type_id, :integer
    end
  end

  def down

  end
end
