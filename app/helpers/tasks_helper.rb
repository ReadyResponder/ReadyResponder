module TasksHelper
  def task_status_class(task)
    color = task_status_color(task.staffing_level)
    return "class=\"#{color}\"" if color
  end

  def task_staffing_label(task)
    content_tag(:span, task.staffing_level, class: task_label_class(task.staffing_level))
  end

  def task_priority_label(task)
    content_tag(:span,
                task.priority_str,
                class: task_priority_label_class(task.priority))
  end

  def task_address
    city = @task.city
    city = @task.city + ', ' if @task.city.present?

    content_tag :div do
      concat content_tag(:p, @task.street)
      concat content_tag(:p, city + @task.state + " #{@task.zipcode}")
    end
  end

  private
    def task_label_class(task_status)
      return nil if task_status.blank?
      color = task_status_color(task_status) || 'default'
      return "label label-#{color}"
    end

    def task_status_color(task_status)
      # The options are found in app/models/task.rb: STATUS_CHOICES
      case task_status
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

    def task_priority_label_class(task_priority)
      return nil if task_priority.blank?
      color = task_priority_color(task_priority) || 'default'
      return "label label-#{color}"
    end

    def task_priority_color(task_priority)
      return 'default'
    end
end
