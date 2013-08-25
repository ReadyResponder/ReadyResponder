# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

jQuery ->
  $("#timeslot_person_id").focus();
  $('#timeslots').dataTable
    sPaginationType: "full_numbers"
    "aoColumns": [null,
                  null,
                  null,
                  null,
                  null,
                  null,
                  null,
                  null,
                  null,
                  {"bSortable" : false},
                  {"bSortable" : false}]
    'bJQueryUI': true
    'bRetrieve': true
    'iDisplayLength': 100
