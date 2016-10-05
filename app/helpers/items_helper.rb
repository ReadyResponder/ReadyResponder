module ItemsHelper
  def item_status_label(item)
    content_tag(:span, item.status, class: item_label_class(item))
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
    def item_label_class(item)
      # The options are found in app/models/item.rb: STATUS_CHOICES
      return nil if item.status.blank?
      case item.status
      when 'Available'
        return 'label label-success'
      when 'In Service', 'In Service - Degraded'
        return 'label label-warning'
      when 'Out of Service', 'Sold', 'Destroyed'
        return 'label label-danger'
      else
        # This should only happen if another status is added.
        return 'label label-default'
      end
    end
end
