# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

jQuery ->
  $('#prospects').dataTable
    sPaginationType: "full_numbers"
    "aoColumns": [null,
                  null,
                  {"bSortable" : false}],
    'bJQueryUI': true
    'bRetrieve': true
    'iDisplayLength': 100