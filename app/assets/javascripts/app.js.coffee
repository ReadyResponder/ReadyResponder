# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
jQuery ->
        $('.datepicker').datepicker
          dateFormat: 'yy-mm-dd'
        $('.datetimepicker').datetimepicker({
          dateFormat: 'yy-mm-dd '
          timeFormat: 'HH:mm '
          stepHour: 1
          stepMinute: 15});
        $('.generic_datatable').dataTable
          pagingType: "full_numbers"
          'retrieve': true
          pageLength: 50
        $('.accordion').accordion
          collapsible: true
          active: false
