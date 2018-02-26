class InspectionTag < ActiveRecord::Base
  has_many :taggings
  has_many :item_types, :through => :taggings, :source => :taggable, :source_type => 'Item_type'
  has_many :item_categories, :through => :taggings, :source => :taggable, :source_type => 'Item_category'
  has_many :inspection_questions, :through => :taggings, :source => :taggable, :source_type => 'Item_question'
end
