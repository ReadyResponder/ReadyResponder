module TasksHelper
  def task_status_label(task)
    content_tag(:span, task.status, class: task_label_class(task))
  end

  private
    def task_label_class(task)
      # The options are found in app/models/task.rb: STATUS_CHOICES
      return nil if task.status.blank?
      case task.status
      when 'Full'
        return 'label label-success'
      when 'Partially Filled'
        return 'label label-warning'
      when 'Empty'
        return 'label label-danger'
      when 'Cancelled'
        return 'label label-default'
      else
        # This should only happen if another status is added.
        return 'label label-default'
      end
    end

end
