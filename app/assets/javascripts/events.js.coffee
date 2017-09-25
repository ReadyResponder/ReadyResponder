jQuery ->
  $("#event_title").focus()
  $table = $('#events').dataTable
    order: [[3, 'asc']],
    columnDefs: [
                  { orderable: false, targets: -1 },
                  { orderData: 2, targets: 3 },
                  { orderData: 4, targets: 5 },
                  { visible: false, targets: [2,4,8] }
                ]

# sets checkbox elements within #events dataTable()
  $('table.datatable caption').append('<label>Current:<input type="checkbox" id="js-events-current-checkbox" class="event-filter" value="current"></label>
  <label>Past:<input type="checkbox" id="js-events-past-checkbox" class="event-filter" value="past"></label>
  <label>Templates:<input type="checkbox" id="js-events-template-checkbox" class="event-filter" value="template"></label>')

#logic handling checkbox filtering with dataTables()
  $.fn.dataTableExt.afnFiltering.push((settings, data) ->
    checked = []
    currentTime = new Date()
    endTime = new Date(data[5])
    isTemplate = data[8]
    $('.event-filter').each ->
      $this = $(this)
      if $this.is(':checked')
        checked.push($this)

    if checked.length
      returnValue = false
      $.each(checked, (i, element) ->
        if (element.val() is 'current' and endTime > currentTime and isTemplate is 'False') or
           (element.val() is 'past' and endTime < currentTime and isTemplate is 'False') or
           (element.val() is 'template' and isTemplate is 'True')
          returnValue = true;
          return false;
          )
    else
      return false
    return returnValue
    )

  #re-draws table after checking or unchecking a filter checkbox
  $('.event-filter').change ->
    $table.fnDraw()

  $("#event_category").change ->
    temp = $("#event_category option:selected").text();
    if temp is "Training"
      $(".training-controls").show()
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

$(document).ready ->
  $("#js-events-current-checkbox").click()
