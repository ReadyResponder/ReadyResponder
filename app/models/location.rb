class Location < ApplicationRecord
  has_many :moves
  belongs_to :department, optional: true

  def to_s
    name
  end
end
