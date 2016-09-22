# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
jQuery ->
        #See application_helper.rb: format_date_value
        $('.datepicker').datetimepicker({
          timepicker: false,
          format:'Y-m-d',
        });
        #See application_helper.rb: format_datetime_value
        $('.datetimepicker').datetimepicker({
          format:'Y-m-d H:i',
          step: 15,
          });
        $('.accordion').accordion
          collapsible: true
          active: false
