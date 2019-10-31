class AddIsTemplateToEvents < ActiveRecord::Migration[4.2]
  def change
    add_column :events, :is_template, :boolean, default: false
  end
end
