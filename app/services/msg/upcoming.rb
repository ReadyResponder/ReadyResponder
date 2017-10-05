class Msg::Upcoming < Msg::Base
  # method called with: @params (From: String, Body: String), @person (Person Object)
  def respond
    events = Event.upcoming.limit(10)
    response = ""
    events.each do |event|
      if event.people.include?(@person)
        response += "🔷 "
      elsif event.available_people.include?(@person)
        response += "✅ "
      elsif event.partially_available_people.include?(@person)
        response += "⚠️ "
      elsif event.unavailable_people.include?(@person)
        response += "❌ "
      else
        response += "? "
      end
      response += "#{event.start_time.strftime('%a %b %d %k:%M')} - " if event.start_time.present?
      response += "#{event.end_time.strftime('%b %d %k:%M')} " if event.end_time.present?
      response += "[#{event.id_code.to_s}] " if event.id_code.present?
      response += event.title.truncate(23) if event.title.present?
      # TODO need to show their status for this event (A, U, X)
      # TODO need to check if they have already responded
      # TODO need to check if they have already assigned to a task
      response += "\n"
    end
    return response
  end
end
