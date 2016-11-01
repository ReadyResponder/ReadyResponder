class Event::FindByCode
  def initialize(*query_param)
    @query_param = query_param
    @query_param = "Beetlejuice" if @query_param.blank?
    @query_param = @query_param.downcase
  end

  def call
    return Event.where(id_code: @query_param).first
  end
end
