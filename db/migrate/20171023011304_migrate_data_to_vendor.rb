class MigrateDataToVendor < ActiveRecord::Migration[4.2]
  def up

    Item.all.each do |item|
      v = Vendor.where(
        name: item.source
      ).first_or_create

      item.vendor_id = v.id
      item.update_columns(vendor_id: v.id)
    end
  rename_column :items, :source, :source_data
  end

  def down
    rename_column :items, :source_data, :source
  end
end
