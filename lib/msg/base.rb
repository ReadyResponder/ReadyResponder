# cmd = "Msg::#{}"
# m=Msg::Base.new().extend(cmd.constantize)
# m.call => "Not Implemented"
class Msg::Base
  def initialize(*args)
    @args = args
  end
end
