# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

jQuery ->
  $("#timecards_person_id").focus();
  $('#timecards').dataTable
    columnDefs: [
                  { orderable: false, targets: 5 }
                ]
jQuery ->
  $('.js-timecard-verify-btn').click (event)->
    event.preventDefault()
    event.stopPropagation()
    $.ajax event.currentTarget.form.action,
      type: 'POST'
      data: { id: event.currentTarget.form.id.value }
      dataType: 'JSON'
      error: (data, error) ->
        console.log("Verify Error: #{error}")
      success: (data) ->
        if data.notice is undefined
          $("#js-notice").empty()
          $("#js-timecard-verify-btn-id-#{data.id}").remove()
          $("#js-timecard-status-id-#{data.id}").html(data.status)
        else
          $("#js-notice").html(data.notice)
