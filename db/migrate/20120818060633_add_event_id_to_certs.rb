class AddEventIdToCerts < ActiveRecord::Migration
  def change
    rename_column :certs, :id_number, :cert_number
    add_column :certs, :grade, :string
    add_column :certs, :event_id, :integer
    rename_column :certs, :date_issued, :issued_date
    rename_column :certs, :date_expires, :expiration_date
    remove_column :certs, :instructor_id
  end
end
