class AddTypeToChannel < ActiveRecord::Migration
#  def change
  #    add_column :channels, :type, :string
  #    add_colum  :channels, :sms_available, :boolean
#  end
  def self.up
    add_column :channels, :type, :string
    add_column :channels, :sms_available, :boolean, :default => false
#    Channel.foo_phone.all.update_attribute(:type => 'phone')
#    Channel.foo_email.all.update_attribute(:type => 'il')
    Channel.where("category LIKE ?", "%Phone%").each do |p|    
      p.update_attribute(:type, 'Phone')
    end
    Channel.where("category LIKE ?", "%Mail%").each do |p|
      p.update_attribute(:type, 'Email')
    end    

  end
    
  def self.down
    remove_column :channels, :type
    remove_column :channels, :sms_available
  end

end
