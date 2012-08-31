class AddCertificationToCerts < ActiveRecord::Migration
  def change
    add_column :certs, :certification, :string
  end
end
