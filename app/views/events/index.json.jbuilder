json.data @events do |event|
  json.id event.id
  json.start_date event.start_time
  json.end_date event.end_time
  json.text event.title
end
