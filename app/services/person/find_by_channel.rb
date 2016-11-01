class Person::FindByChannel
  def initialize(*query_param)
   @query_param = query_param
  end

  def call
    cell = Phone.where(content: @query_param[0][2..12]).first
    return cell.person if cell
  end
end
