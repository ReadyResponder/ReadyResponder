class Helpdoc < ActiveRecord::Base
  attr_accessible :contents, :help_for_section, :help_for_view, :title
end

