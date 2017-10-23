class ChangeColumnPeopleZipcode < ActiveRecord::Migration
  def up
    change_column :people, :zipcode, :string, limit: 10
  end

  def down
    change_column :people, :zipcode, :string
  end
end
