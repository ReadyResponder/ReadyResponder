class ChangeColumnPeopleZipcode < ActiveRecord::Migration[4.2]
  def up
    change_column :people, :zipcode, :string, limit: 10
  end

  def down
    change_column :people, :zipcode, :string
  end
end
