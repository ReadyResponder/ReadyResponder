class Msg::Upcoming < Msg::Base
  def respond
    events = Event.upcoming.limit(5)
    response = ""
    events.each do |event|
      response += "#{event.start_time.strftime('%a %b %d %k:%M')} - " if event.start_time.present?
      response += "#{event.end_time.strftime('%b %d %k:%M')} " if event.end_time.present?
      response += " [#{event.id_code.to_s}] " if event.id_code.present?
      response += event.title.truncate(23) if event.title.present?
      # TODO need to show their status for this event (A, U, X)
      # TODO need to check if they have already responded
      # TODO need to check if they have already assigned to a task
      response += "\n"
    end
    return response
  end
end
