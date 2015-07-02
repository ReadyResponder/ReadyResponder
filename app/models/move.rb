class Move < ActiveRecord::Base
  attr_accessible :comments, :item_id, :locatable_id, :locatable_type, :reason
end

