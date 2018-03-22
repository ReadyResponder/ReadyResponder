class InspectionQuestion < ActiveRecord::Base
  has_paper_trail
  include Loggable

  belongs_to :inspection
  belongs_to :question
  has_many :taggings, :as => :taggable
  has_many :tags, :through => :taggings
end
