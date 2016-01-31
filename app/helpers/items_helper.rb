module ItemsHelper
  def item_label(item)
     return nil if item.status.blank?
     return 'label-warning' if item.status == 'Out of Service'
     return 'label-success' if item.status == 'Available'
  end
  def edit_item_button
    return nil if cannot? :edit, @item
    return link_to ' Edit Item ',
                      edit_item_path(@item),
                      :class => 'btn btn-primary'
  end
  def add_repair_button
    return nil if cannot? :create, Repair
    return link_to ' Add Repair ',
                      new_item_repair_path(@item),
                      :class => 'btn btn-primary'
  end
  def add_inspection_button
    return nil if cannot? :create, Inspection
    return link_to 'Add Inspection',
                      new_item_inspection_path(@item),
                      :class => 'btn btn-primary'
  end
end
