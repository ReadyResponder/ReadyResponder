class Question < ActiveRecord::Base
  has_paper_trail
  include Loggable

end
