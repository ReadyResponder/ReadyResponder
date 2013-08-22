class ChangeTimeslotsToIntentionAndOutcome < ActiveRecord::Migration
  def up
    rename_column :events, :status, :intention
    add_column :events, :outcome
  end

  def down
    rename_column :events, :intention, :status
    remove_column :events, :outcome
  end
end
