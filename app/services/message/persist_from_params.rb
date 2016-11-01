class Message::PersistFromParams

  def initialize(*query_param)
    @query_param = query_param[0]
    @query_param = "Beetlejuice" if @query_param.blank?
    @query_param = @query_param.downcase
  end

  def call
    "Not Implemented; Waiting for Message model"
  end
end
