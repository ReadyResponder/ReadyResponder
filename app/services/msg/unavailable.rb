class Msg::Unavailable < Msg::Base
  def respond
    target = Event::FindByCode.call(@params[:Body].split[1])
    return target if target.is_a? Error::Base

    # TODO Need to verify and save Availabilites as needed.
    availability = Availability::CreateFromTextMsg.call(@params,
                                 @person, target, "Unavailable")
    return availability
end
end
