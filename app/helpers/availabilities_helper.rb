module AvailabilitiesHelper
  def availability_status_label(availability)
    content_tag(:span, availability.status, class: availability_label_class(availability))
  end

  def availability_status_class(availability)
    case availability.status
    when 'Available'
      return 'class="success"'
    when 'Unavailable', 'Cancelled'
      return 'class="danger"'
    else
      return nil
    end
  end
  private
    def availability_label_class(availability)
      # The options are found in app/models/availability.rb: STATUS_CHOICES
      return nil if availability.status.blank?
      case availability.status
      when 'Available'
        return 'label label-success'
      when 'Unavailable'
        return 'label label-danger'
      else
        # including 'Cancelled'
        return 'label label-default'
      end
    end
end
