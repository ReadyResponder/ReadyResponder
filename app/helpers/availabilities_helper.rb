module AvailabilitiesHelper
  def availability_status_label(availability, event = nil)
    if availability.partially_available?(event)
      content_tag(:span, availability.status == "Available" ? "Partially Available" : availability.status, class: availability_label_class(availability, true))
    else
      content_tag(:span, availability.status, class: availability_label_class(availability, false))
    end
  end

  def availability_status_class(availability, event = nil)
    case availability.status
    when 'Available'
      return availability.partially_available?(event) ? 'class="warning"' : 'class="success"'
    when 'Unavailable', 'Cancelled'
      return 'class="danger"'
    else
      return nil
    end
  end

  private
    def availability_label_class(availability, partial)
      # The options are found in app/models/availability.rb: STATUS_CHOICES
      return nil if availability.status.blank?
      case availability.status
      when 'Available'
        return partial ? 'label label-warning' : 'label label-success'
      when 'Unavailable'
        return 'label label-danger'
      else
        # including 'Cancelled'
        return 'label label-default'
      end
    end
end
