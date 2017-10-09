class ChangeMinRankType < ActiveRecord::Migration
  def change
    change_column :events, :min_title, :string, :default => Person::TITLES[Person::TITLES.length - 1]
  end
end
