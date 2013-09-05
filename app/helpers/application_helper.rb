module ApplicationHelper
=begin
  def link_to_add_fields(name, f, association)
    new_object = f.object.send(association).klass.new
    id = new_object.object_id
    fields = f.fields_for(association, new_object, child_index: id) do |builder|
      render(association.to_s.singularize + "_fields", f: builder)
    end
    link_to(name, '#', class: "add_fields", data: {id: id, fields: fields.gsub("\n", "")})
  end
=end
  #This is code to implement presenters, based on Ryan Bates Railcasts #287
  #Sadly it had typos in the Asciicasts version
  #Error on html_safe not available, the template is not getting set
  def present(object, klass = nil)
    klass ||= "#{object.class}Presenter".constantize
    presenter = klass.new(object, self)
    if block_given?
      yield presenter
    else
      presenter
    end
  end
end