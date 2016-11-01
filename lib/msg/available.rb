module Msg::Available
  def respond
    # This module is used for available or unavailable.
    # We need to pull the event code out and find it for ourselves,
    # since not all texts will reference a specific event.
    @args = @args[0] # Get rid of the array from the splat in Msg::Base
    person = @args[:person]
    params = @args[:params]
    status_synonyms = {Available: "Available", Yes: "Available",
                       Unavailable: "Unavailable", No: "Unavailable" }
    first_word = params[:Body].split[0]
    status = status_synonyms[first_word.to_sym]
    id_code = params[:Body].split[1]
    return "No id_code given" if id_code.blank?
    event = Event.where(id_code: id_code).first
    return "Event not found" if event.blank?
    description = params[:Body].split[2]
    # TODO Need to verify and save Availabilites as needed.
    avail = Availability.new do |a|
      a.person = person
      a.start_time = event.start_time
      a.end_time = event.end_time
      a.status = status
      a.description = description
    end
    return "Availabilty recorded #{avail.inspect}"
  end
end
