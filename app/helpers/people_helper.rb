module PeopleHelper
  def display_date_with_days_hint(person, field_name)
    html = '<td title="'
    html += person.send(field_name).strftime('%a %b %d') + '" '
    html += td_class_string(person, field_name) + ' > '
    html += distance_of_time_in_words(person.send(field_name), Date.today)
    html += '</td>'

    raw html
  # return 1/0
  end

  private
  def td_class_string(person, field_name)
    case (Date.today - person.send(field_name).to_date).to_i
    when 14..60000
      return 'class="danger"'
    when 7..14
      return 'class="warning"'
    else
      return ''
    end
  end
end
