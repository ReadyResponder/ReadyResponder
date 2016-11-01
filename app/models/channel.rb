class Channel < ActiveRecord::Base
  belongs_to :person

  USAGES = ['1-All','2-Emergency Only','3-Info Only','4-Testing']
  STATUSES = ['OK','Invalid']
  CATEGORIES = ['Home','Business']
  CHANNEL_TYPES = ["Email", "Cell", "Landline", "Phone", "Text"]

  def phone?
    ["Phone", 'Cell', 'Landline'].include?(self.channel_type)
  end
end
