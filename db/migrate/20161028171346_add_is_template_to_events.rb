class AddIsTemplateToEvents < ActiveRecord::Migration
  def change
    add_column :events, :is_template, :boolean, default: false
  end
end
