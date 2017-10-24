class MigrateDataToVendor < ActiveRecord::Migration
  def up

    Item.all.each do |item|
      v = Vendor.where(
        name: item.source
      ).first_or_create

      item.vendor_id = v.id
      item.update_columns(vendor_id: v.id)
    end

  remove_column :items, :source
  end

  def down
    add_column :items, :source, :string
  end
end
