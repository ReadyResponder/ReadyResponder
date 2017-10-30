class Role < ApplicationRecord
  has_and_belongs_to_many :users

  def to_s
    self.name.to_s
  end

end
