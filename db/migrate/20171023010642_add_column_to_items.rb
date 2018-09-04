class AddColumnToItems < ActiveRecord::Migration[4.2]
  def change
    add_belongs_to :items, :vendor
  end
end
