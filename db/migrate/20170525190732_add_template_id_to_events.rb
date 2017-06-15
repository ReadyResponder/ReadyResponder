class AddTemplateIdToEvents < ActiveRecord::Migration
  def change
    add_column :events, :template_id, :integer
  end
end
