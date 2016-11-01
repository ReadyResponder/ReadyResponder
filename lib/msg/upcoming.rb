module Msg::Upcoming
  def respond
    events = Event.upcoming.limit(5)
    response = ""
    events.each do |event|
      response = "S(#{event.start_time.to_s}) " if event.start_time.present?
      response += "E(#{event.end_time.to_s}) " if event.end_time.present?
      response += truncate(event.title) if event.title.present?
      response += " (#{event.id_code.to_s}) " if event.id_code.present?
  #    response += " (#{event.id_code.to_s}) " if event.id_code.present?
      # TODO need to show their status for this event (A, U, X)
      # TODO need to check if they have already responded
      # TODO need to check if they have already assigned to a task
      response += + "\n"
    end
    return response
  end
end
