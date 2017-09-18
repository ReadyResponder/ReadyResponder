
jQuery ->
  $("#event_title").focus();
  table = $('#events').dataTable
    "dom": '<"eventToolbar dataTables_filter">frtip',
    order: [[3, 'asc']],
    columnDefs: [
                  { orderable: false, targets: -1 },
                  { orderData: 2, targets: 3 },
                  { orderData: 4, targets: 5 },
                  { visible: false, targets: [2,4,8] }
                ]

  $('div.eventToolbar').html('<label>Current:<input type="checkbox" id="js-events-current-checkbox" name="event-filter"></label>
  <label>Past:<input type="checkbox" id="js-events-past-checkbox" name="event-filter"></label>
  <label>Templates:<input type="checkbox" id="js-events-template-checkbox" name="event-filter"></label>')

  filterCheckboxes = (element, criteria) ->
    $.fn.dataTable.ext.search.push((settings, data, dataIndex) ->
      checkboxState = element.checked
      itemStatus  = data[7]
      endTime = new Date(data[5])
      isTemplate = data[8]

      if criteria.type is "current"
        if (checkboxState is false) or (checkboxState is true and
            endTime > criteria.dateTime)
          return true
        return false
      else if criteria.type is "past"
        if (checkboxState is false) or (checkboxState is true and
            endTime < criteria.dateTime)
          return true
        return false
      else if criteria.type is "template"
        if (checkboxState is false) or (checkboxState is true and
            isTemplate is "True")
          return true
        return false
      )
    table.fnDraw()

  $('#js-events-current-checkbox').click ->
    $("#js-events-past-checkbox").prop('checked', false)
    criteria = {
      type: "current",
      dateTime: new Date()
    }
    filterCheckboxes(this, criteria)

  $('#js-events-past-checkbox').click ->
    $("#js-events-current-checkbox").prop('checked', false)
    criteria = {
      type: "past",
      dateTime: new Date()
    }
    filterCheckboxes(this, criteria)

  $('#js-events-template-checkbox').click ->
    criteria = {
      type: "template",
      status: ["Active", "Inactive"]
    }
    filterCheckboxes(this, criteria)

  $("#event_category").change ->
    temp = $("#event_category option:selected").text();
    if temp is "Training"
      $(".training-controls").show()
      $(".training-controls").css("display", "block")
    else
      $(".training-controls").hide()
  $("#event_status").change ->
    status = $("#event_status option:selected").text();
    start_time = $("#event_start_time").text();
    if status is "Completed"
      $("#XXevent_start_time").hide()

  $('a[data-toggle="tab"]').on 'shown.bs.tab', (e) ->
    $.fn.dataTable.tables(
      visible: true
      api: true).columns.adjust()
    return

  $('#event_start_time').change ->
    eventStartTime = $('#event_start_time').datetimepicker('getValue')
    eventEndTime = $('#event_end_time').datetimepicker('getValue')
    if (not eventEndTime?) or (eventStartTime > eventEndTime)
      $('#event_end_time').datetimepicker('setOptions', {startDate: eventStartTime})
