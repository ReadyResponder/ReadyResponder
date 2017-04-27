module ItemsHelper

  def item_condition_label(item)
    content_tag(:span, item.condition, class: item_condition_class(item))
  end

  def item_status_label(item)
    content_tag(:span, item.status, class: item_status_class(item))
  end

  def edit_item_button
    return nil if cannot? :edit, @item
    return link_to 'Edit Item',
                   edit_item_path(@item),
                   class: 'btn btn-block btn-primary'
  end
  def add_repair_button
    return nil if cannot? :create, Repair
    return link_to 'Add Repair',
                   new_item_repair_path(@item),
                   class: 'btn btn-block btn-primary'
  end
  def add_inspection_button
    return nil if cannot? :create, Inspection
    return link_to 'Add Inspection',
                   new_item_inspection_path(@item),
                   class: 'btn btn-block btn-primary'
  end

  private
    def item_status_class(item)
      # The options are found in app/models/item.rb: STATUS_CHOICES
      # ['Assigned', 'Unassigned', 'Retired']
      return nil if item.status.blank?
      case item.status
      when 'Assigned'
        return 'label label-info'
      when 'Unassigned'
        return 'label label-success'
      when 'In-Service - Maintenance', 'In-Service - Degraded'
        return 'label label-warning'
      when 'Out of Service', 'Retired'
        return 'label label-danger'
      else
        # This should only happen if another status is added.
        return 'label label-default'
      end
    end

    def item_condition_class(item)
      # The options are found in app/models/item.rb: STATUS_CHOICES
      # ['Ready', 'In-service - Maintenance', 'In-service - Degraded', 'Out of Service' ]
      return nil if item.condition.blank?
      case item.condition
      when 'Ready'
        return 'label label-success'
      when 'In-service - Maintenance', 'In-Service - Degraded'
        return 'label label-warning'
      when 'Out of Service', 'Retired'
        return 'label label-danger'
      else
        # This should only happen if another status is added.
        return 'label label-default'
      end
    end
end
