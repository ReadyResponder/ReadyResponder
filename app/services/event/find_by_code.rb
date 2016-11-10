class Event::FindByCode
  # We don't ever call new, we don't need initialize
  # def initialize(*query_param)
  #   @query_param = query_param
  #   @query_param = "Beetlejuice" if @query_param.blank?
  #   @query_param = @query_param.downcase
  # end

  def self.call(id_code)
    return Error::Base.new({code: 211, description: "No id_code given"}) if id_code.blank?
    event = Event.where(id_code: id_code).first
    return Error::Base.new({code: 201, description: "Event not found"}) if event.blank?
    return event
  end
end
