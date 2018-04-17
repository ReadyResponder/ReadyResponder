class ChangeColumnDefaultTitleOrderPerson < ActiveRecord::Migration
  def change
    change_column_null :people, :title_order, false, 100
  end
end
