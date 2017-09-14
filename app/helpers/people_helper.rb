module PeopleHelper
  def display_date_with_days_hint(a_date)
    html = "<td title=#{a_date} >"
    html += distance_of_time_in_words(a_date, Date.today)
    html += '</td>'

    raw html
  end
end
