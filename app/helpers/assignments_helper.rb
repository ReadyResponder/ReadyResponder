module AssignmentsHelper
  def assignment_status_class(assignment)
    case assignment.status
    when 'New', 'Active'
      return 'class="info"'
    when 'Cancelled'
      return 'class="danger"'
    else
      return nil
    end
  end
end
