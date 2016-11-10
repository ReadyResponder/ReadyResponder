class Msg::Available < Msg::Base
  def respond
    target = Event::FindByCode.call(@params[:Body].split[1])
    return target if target.is_a? Error::Base
  # target = Notification::FindByCode.call(@params[:Body].split[1])

    # TODO Need to verify and save Availabilites as needed.
    availability = Availability::CreateFromTextMsg.call(@params,
                                                  @person, target, "Available")
    return availability
  end
end
