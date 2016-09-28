module InspectionsHelper
  def inspection_status_label(inspection)
    content_tag(:span, inspection.status, class: inspection_label_class(inspection))
  end

  private
    def inspection_label_class(inspection)
      # The options are found in app/models/inspection.rb: STATUS_CHOICES
      return nil if inspection.status.blank?
      case inspection.status
      when 'Complete - Passed'
        return 'label label-success'
      when 'Incomplete'
        return 'label label-warning'
      when 'Complete - Failed'
        return 'label label-danger'
      else
        # This should only happen if another status is added.
        return 'label label-default'
      end
    end
end
