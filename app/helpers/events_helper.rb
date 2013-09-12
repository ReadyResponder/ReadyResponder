module EventsHelper

  def elapsed_time(timecard)
    distance_of_time_in_words((Time.current), timecard.actual_start_time) if timecard.actual_start_time
  end

  def unavailable_button(timecard)
    if can? :update, timecard and ["Scheduled", "In-session"].include? @event.status
      button = link_to("Unavailable", timecard_path(timecard, intention: "Unavailable"), method: :Put, :class => 'btn btn-mini')
    end
    return raw button
  end

  def available_button(timecard)
    if can? :update, timecard and ["Scheduled", "In-session"].include? @event.status
      button = link_to("Available", timecard_path(timecard, intention: "Available"), method: :Put, :class => 'btn btn-mini')
    end
    return raw button
  end

  def scheduled_button(timecard)
    if can? :update, timecard and ["Scheduled", "In-session"].include? @event.status
      button = link_to("Scheduled", timecard_path(timecard, intention: "Scheduled"), method: :Put, :class => 'btn btn-mini')
    end
    return raw button
  end

  def worked_button(timecard)
    if can? :update, timecard and ["In-session", "Completed"].include? @event.status
      button = link_to("Worked", timecard_path(timecard, outcome: "Worked"), method: :Put, :class => 'btn btn-mini')
    end
    raw button
  end

  def edit_button(timecard)
    if can? :update, timecard
      button = link_to('Edit', edit_timecard_path(timecard), :class => "btn btn-mini")
    end
    return raw button
  end

end
