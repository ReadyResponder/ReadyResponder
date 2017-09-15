module PeopleHelper
  def display_date_with_days_hint (person, field_name)
    html = '<td title="'
    html += person.send(field_name).strftime('%a %b %d') + '" '
    html += td_class_string(person, field_name) + ' > '
    html += distance_of_time_in_words(person.send(field_name), Time.zone.today)
    html += '</td>'

    raw html
  # return 1/0
  end

  def display_hours_worked (person)
    html = '<td>'
    html += person.timecards.where('start_time > ?', 3.months.ago).sum(:duration).to_s
    html += '/'
    html += person.timecards.where('start_time > ?', 6.months.ago).sum(:duration).to_s
    html += '/'
    html += person.timecards.where('start_time > ?', 12.months.ago).sum(:duration).to_s
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
