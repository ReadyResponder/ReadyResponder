class Msg::Base
  def initialize(args)
    @person = args[:person]
    @params = args[:params]
  end

  def body
    @body ||= @params[:Body] if @params.has_key? :Body
  end

  def body_words
    return [] unless body
    @body_words ||= @body.split
  end

  def body_size
    return 0 unless body
    @body_size ||= body_words.count
  end

  def get_event_codename
    return nil unless body
    @event_codename ||= body_words[1].downcase
  end
  # The alias allows us to treat the event_codename as an
  # instance attribute
  alias :event_codename :get_event_codename
end
