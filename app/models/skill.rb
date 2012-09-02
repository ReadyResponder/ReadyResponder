class Skill < ActiveRecord::Base
  attr_accessible :required_for_cert, :required_for_pd, :required_for_sar, :status, :title
end
