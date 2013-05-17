class Addsourcetoitem < ActiveRecord::Migration
  def change
    add_column :items, :grant, :string
    add_column :items, :grantstart, :date
    add_column :items, :grantexpiration, :date
    add_index "certs", ["person_id"], :name => "index_certs_on_person_id"
    add_index "inspections", ["person_id"], :name => "index_inspections_on_person_id"
  end

end
