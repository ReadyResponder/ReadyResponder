class AddTemplateIdToEvents < ActiveRecord::Migration[4.2]
  def change
    add_column :events, :template_id, :integer
  end
end
