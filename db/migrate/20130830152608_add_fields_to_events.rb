class AddFieldsToEvents < ActiveRecord::Migration
  def change
    add_column :events, :error_code, :string
    add_column :events, :id_code, :string  #This is to allow direct access to event
  end
end
