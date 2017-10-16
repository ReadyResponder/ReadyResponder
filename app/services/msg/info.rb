class Msg::Info < Msg::TemplatedBase
  # method called with: @params (From: String, Body: String), @person (Person Object)
  def respond
    codename = get_event_codename
    target = Event.find_by_code(codename)
    return target if target.is_a? Error::Base

    template_locals[:event] = target
    template_locals[:person] = @person
    super
  end
end

