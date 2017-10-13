class ChangeColumnPeopleZipcode < ActiveRecord::Migration
  def change
    change_column :people, :zipcode, :string, limit: 5
  end
end
