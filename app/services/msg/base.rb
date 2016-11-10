class Msg::Base
  def initialize(args)
    @person = args[:person]
    @params = args[:params]
  end

end
