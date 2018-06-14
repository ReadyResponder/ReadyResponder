class AddColumnToItems < ActiveRecord::Migration
  def change
    add_belongs_to :items, :vendor
  end
end
