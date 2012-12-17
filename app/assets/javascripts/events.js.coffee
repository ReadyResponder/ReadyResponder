# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
jQuery ->
        $('#events').dataTable
          sPaginationType: "full_numbers"
          bJQueryUI: true
          iDisplayLength: 50
        $('#event_start_date').datepicker
          dateFormat: 'yy-mm-dd'
        $('#event_end_date').datepicker
          dateFormat: 'yy-mm-dd'
