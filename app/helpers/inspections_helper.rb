module InspectionsHelper
  def inspection_label(inspection)
    # The options are found in app/models/inspection.rb: STATUS_CHOICES
    return nil if inspection.status.blank?
    case inspection.status
    when 'Complete - Passed'
      return 'label-success'
    when 'Incomplete'
      return 'label-warning'
    when 'Complete - Failed'
      return 'label-danger'
    else
      # This should only happen if another status is added.
      return 'label-default'
    end
  end
end
