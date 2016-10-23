module RequirementsHelper
  def requirement_status_class(requirement)
    color = requirement_status_color(requirement.status)
    return "class=\"#{color}\"" if color
  end

  def requirement_status_label(requirement)
    content_tag(:span, requirement.status, class: requirement_status_label_class(requirement.status))
  end

  def requirement_priority_label(requirement)
    content_tag(:span,
                requirement.priority_str,
                class: requirement_priority_label_class(requirement.priority))
  end

  private
    def requirement_status_label_class(requirement_status)
      return nil if requirement_status.blank?
      color = requirement_status_color(requirement_status) || 'default'
      return "label label-#{color}"
    end

    def requirement_status_color(requirement_status)
      # The options are found in app/models/requirement.rb: STATUS_CHOICES
      case requirement_status
      when 'Full', 'Satisfied'
        return 'success'
      when 'Adequate'
        return 'warning'
      when 'Inadequate', 'Empty'
        return 'danger'
      else
        return nil
      end
    end

    def requirement_priority_label_class(requirement_priority)
      return nil if requirement_priority.blank?
      color = requirement_priority_color(requirement_priority) || 'default'
      return "label label-#{color}"
    end

    def requirement_priority_color(requirement_priority)
      return 'default'
    end
end
