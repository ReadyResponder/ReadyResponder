class ChangeColumnDefaultTitleOrderPerson < ActiveRecord::Migration[4.2]
  def change
    change_column_null :people, :title_order, false, 100
  end
end
