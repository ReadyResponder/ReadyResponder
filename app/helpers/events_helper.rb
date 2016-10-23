module EventsHelper

  def event_status_label(event)
    make_label(event.status, event_label_class(event))
  end

  def display_event_status(event)
    available            = event.availabilities.count.to_s
    partially_available  = event.partial_availabilities.count.to_s
    unavailable          = event.unavailabilities.count.to_s
    no_response          = event.unresponsive_people.count.to_s
    content_tag(:div) {
      capture do
        concat event_status_label(event)
        concat content_tag(:span, 'Personnel:', class: 'event-labels')
        concat make_label(available, 'label label-success event-labels', tooltip: 'Available')
        concat make_label(partially_available, 'label label-warning event-labels', tooltip: 'Partially Available')
        concat make_label(unavailable, 'label label-danger event-labels', tooltip: 'Unavailable')
        concat make_label(no_response, 'label label-default event-labels', tooltip: 'No Response')
      end
    }
  end

  def elapsed_time(timecard)
    distance_of_time_in_words((Time.current), timecard.actual_start_time) if timecard.actual_start_time
  end

  def unavailable_button(timecard)
    if can? :update, timecard and ["Scheduled", "In-session"].include? @event.status
      button = link_to("Unavailable", timecard_path(timecard, intention: "Unavailable"), method: :Put, class: 'btn btn-xs btn-primary')
    end
    return raw button
  end

  def available_button(timecard)
    if can? :update, timecard and ["Scheduled", "In-session"].include? @event.status
      button = link_to("Available", timecard_path(timecard, intention: "Available"), method: :Put, class: 'btn btn-xs btn-primary')
    end
    return raw button
  end

  def scheduled_button(timecard)
    if can? :update, timecard and ["Scheduled", "In-session"].include? @event.status
      button = link_to("Scheduled", timecard_path(timecard, intention: "Scheduled"), method: :Put, class: 'btn btn-xs btn-primary')
    end
    return raw button
  end

  def worked_button(timecard)
    if can? :update, timecard and ["In-session", "Completed"].include? @event.status
      button = link_to("Worked", timecard_path(timecard, outcome: "Worked"), method: :Put, class: 'btn btn-xs btn-primary')
    end
    return raw button
  end

  def edit_button(timecard)
    if can? :update, timecard
      button = link_to('Edit', edit_timecard_path(timecard), class: "btn btn-xs btn-primary")
    end
    return raw button
  end

  private
    def make_label(text, class_str, tooltip: nil)
      if tooltip
        content_tag(:span, text, class: class_str,
                    title: tooltip,
                    data: {toggle: 'tooltip', placement: 'bottom'})
      else
        content_tag(:span, text, class: class_str)
      end
    end

    def event_label_class(event)
      # The options are found in app/models/event.rb: STATUS_CHOICES
      return nil if event.status.blank?
      case event.status
      when 'Scheduled', 'In-session', 'Completed'
        return 'label label-success'
      when 'Cancelled', 'closed'
        return 'label label-warning'
      else
        # This should only happen if another status is added.
        return 'label label-default'
      end
    end

end
