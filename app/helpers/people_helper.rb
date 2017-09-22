module PeopleHelper
  def display_date_with_days_hint (person, field_name)
    html = '<td title="'
    html += distance_of_time_in_words(person.send(field_name), Time.zone.today) + '" '
    html += td_class_string(person, field_name) + ' > '
    html += person.send(field_name).strftime('%a %b %d')
    html += '</td>'

    raw html
  # return 1/0
  end

  def display_hours_worked (person)
    html = '<td>'
    html += person.monthly_hours_going_back(3)
    html += '/'
    html += person.monthly_hours_going_back(6)
    html += '/'
    html += person.monthly_hours_going_back(12)
    html += ' hours</td>'

    raw html
  end

  private
  def td_class_string (person, field_name)
    case (Time.zone.today - person.send(field_name).to_date).to_i
    when 14..60000 # Look this up !
      return 'class="danger"'
    when 7..14
      return 'class="warning"'
    else
      return ''
    end
  end
end
