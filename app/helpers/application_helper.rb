module ApplicationHelper
  def nav_link(link_text, link_path, http_method=nil)
    class_name = current_page?(link_path) ? 'active' : ''

    content_tag(:li, class: class_name) do
      if http_method
        link_to(link_text, link_path, method: http_method)
      else
        link_to(link_text, link_path)
      end
    end
  end

  # Helper function for sidebar_button_link and table_button_link
  def add_class_and_confirmation(default_class, default_delete_class, default_confirm_delete_msg, html_options)
    if html_options[:method] == :delete
      html_options[:class] ||= default_delete_class
      html_options[:data] ||= { confirm: default_confirm_delete_msg }
      html_options[:data][:confirm] ||= default_confirm_delete_msg
    else
      html_options[:class] ||= default_class
    end
  end

  # Wrapper for link_to (Rails)
  # Automatically adds class and/or delete confirmation (if absent),
  # before passing them on to link_to.
  # Uses add_class_and_confirmation, which contains the logic.
  # Uses btn-block (which spans the width of the parent element) for the sidebar.
  # Examples:
  # <%= sidebar_button_link 'Edit Person', edit_person_path(@person) %>
  # <%= sidebar_button_link 'Edit Person', edit_person_path(@person), class: 'btn btn-block btn-warning' %>
  # <%= sidebar_button_link 'Destroy Person', @person, method: :delete %>
  # <%= sidebar_button_link 'Destroy Person', @person, method: :delete, class: 'btn btn-block btn-success' %>
  def sidebar_button_link(name = nil, options = nil, html_options = nil, &block)
    default_class =              'btn btn-block btn-primary'
    default_delete_class =       'btn btn-block btn-danger'
    default_confirm_delete_msg = 'Are you sure?'
    html_options ||= {}
    add_class_and_confirmation(default_class, default_delete_class, default_confirm_delete_msg, html_options)
    link_to(name, options, html_options, &block)
  end

  # Wrapper for link_to (Rails)
  # Automatically adds class and/or delete confirmation (if absent),
  # before passing them on to link_to.
  # Uses add_class_and_confirmation, which contains the logic.
  # Uses btn-xs for tables.
  # Examples:
  # <%= table_button_link 'Edit Person', edit_person_path(@person) %>
  # <%= table_button_link 'Edit Person', edit_person_path(@person), class: 'btn btn-xs btn-warning' %>
  # <%= table_button_link 'Destroy Person', @person, method: :delete %>
  # <%= table_button_link 'Destroy Person', @person, method: :delete, class: 'btn btn-xs btn-success' %>
  def table_button_link(name = nil, options = nil, html_options = nil, &block)
    default_class =              'btn btn-xs btn-primary'
    default_delete_class =       'btn btn-xs btn-danger'
    default_confirm_delete_msg = 'Are you sure?'
    html_options ||= {}
    add_class_and_confirmation(default_class, default_delete_class, default_confirm_delete_msg, html_options)
    link_to(name, options, html_options, &block)
  end

  # Wrapper for link_to (Rails)
  # Automatically adds class and/or delete confirmation (if absent),
  # before passing them on to link_to.
  # Uses add_class_and_confirmation, which contains the logic.
  # Uses btn-md for free-standing buttons.
  # Examples:
  # <%= independent_button_link 'Edit Person', edit_person_path(@person) %>
  # <%= independent_button_link 'Edit Person', edit_person_path(@person), class: 'btn btn-md btn-warning' %>
  # <%= independent_button_link 'Destroy Person', @person, method: :delete %>
  # <%= independent_button_link 'Destroy Person', @person, method: :delete, class: 'btn btn-md btn-success' %>
  def independent_button_link(name = nil, options = nil, html_options = nil, &block)
    default_class =              'btn btn-md btn-primary'
    default_delete_class =       'btn btn-md btn-danger'
    default_confirm_delete_msg = 'Are you sure?'
    html_options ||= {}
    add_class_and_confirmation(default_class, default_delete_class, default_confirm_delete_msg, html_options)
    link_to(name, options, html_options, &block)
  end

  def link_to_add_fields(name, f, association)
    new_object = f.object.send(association).klass.new
    id = new_object.object_id
    fields = f.fields_for(association, new_object, child_index: id) do |builder|
      render(association.to_s.singularize + "_fields", f: builder)
    end
    link_to(name, '#', class: "add_fields", data: {id: id, fields: fields.gsub("\n", "")})
  end

  # This is a general helper to provide a simple success or warning
  # label.  For anything more precise, a custom helper should be
  # used (as in items_helper.rb)
  def success_or_warning_label(str, success_str)
    content_tag(:span, str, class: success_or_warning_label_class(str, success_str))
  end

  # This is a general helper to provide a simple success tag when appropriate.
  # This should be called with raw or with <%==
  def success_class_if_match(str, success_str)
    return 'class="success"' if str == success_str
  end

  # This is for providing a date for a form in an order that Rails can understand.
  # It should match the format used by the datepicker/datetimepicker widget.
  # See app.js.coffee.
  def format_date_value(date)
    date.strftime("%Y-%m-%d") if date
  end

  # As above, but for datetime.
  def format_datetime_value(datetime)
    datetime.strftime("%Y-%m-%d %H:%M") if datetime
  end

  private
    def success_or_warning_label_class(str, success_str)
      if str == success_str
        return 'label label-success'
      else
        return 'label label-warning'
      end
    end

end
