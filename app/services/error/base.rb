class Error::Base
  attr_accessor :description, :code
  def initialize(args)
    @description = args[:description]
    @code = args[:code]
  end

  def to_s
    "(#{code}) #{description}"
  end
end
