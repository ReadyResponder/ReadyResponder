# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

jQuery ->
  $("#person_firstname").focus();
  $('#people').dataTable
    sPaginationType: "full_numbers"
    "aoColumns": [
                  { "bVisible": false },
                  { "iDataSort": 1 },
                  { "bVisible": false },
                  { "iDataSort": 3 },
                   null,
                  {"bVisible": false },
                  { "iDataSort": 5 },
                  null,
                  null,
                  null,
                  null,
                  {"bSortable" : false}]
    'bJQueryUI': true
    'bRetrieve': true
    'iDisplayLength': 100
