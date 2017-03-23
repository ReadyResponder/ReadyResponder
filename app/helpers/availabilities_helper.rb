module AvailabilitiesHelper
  def availability_status_label(a, event = nil)
    if a.class.to_s=='Assignment'
      content_tag(:span, 'Assigned', class: 'label label-info')
    elsif a.partially_available?(event)
      content_tag(:span, a.status == "Available" ? "Partially Available" : a.status,
                  class: availability_label_class(a, true))
    else
      content_tag(:span, a.status, class: availability_label_class(a, false))
    end
  end

  def availability_status_class(a, event = nil)
    return 'class="info"' if a.class.to_s=='Assignment'
    case a.status
    when 'Available'
      return a.partially_available?(event) ? 'class="warning"' : 'class="success"'
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
