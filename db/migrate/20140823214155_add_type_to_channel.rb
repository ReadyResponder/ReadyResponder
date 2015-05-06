class AddTypeToChannel < ActiveRecord::Migration
  def self.up
    add_column :channels, :channel_type, :string
    add_column :channels, :sms_available, :boolean, :default => false
    Channel.where("category LIKE ?", "%Phone%").each do |p|    
      p.update_attribute(:channel_type, 'Phone')
    end
    Channel.where("category LIKE ?", "%Mail%").each do |p|
      p.update_attribute(:channel_type, 'Email')
    end

  end

  def self.down
    remove_column :channels, :channel_type
    remove_column :channels, :sms_available
  end

end
