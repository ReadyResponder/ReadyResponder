class Msg::Base
  def initialize(args)
    @person = args[:person]
    @params = args[:params]
  end

  def get_event_codename
    if @params.has_key?(:Body) and @params[:Body].present?
      return @params[:Body].split[1].downcase
    end
    nil
  end

end
