# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

jQuery ->
  $("#person_firstname").focus();
  $(".training-controls").hide();
  $("#event_category").change ->
    temp = $("#event_category option:selected").text();
    if temp is "Training" 
      $(".training-controls").show()
    else
      $(".training-controls").hide()
  $('#people').dataTable
    sPaginationType: "full_numbers"
    "aoColumns": [null, 
                  { "bVisible": false }, 
                  { "iDataSort": 1 }, 
                  { "bVisible": false }, 
                  { "iDataSort": 3 }, 
                  {"bVisible": false }, 
                  { "iDataSort": 5 }, 
                  null, 
                  null, 
                  null, 
                  {"bSortable" : false}]
    'bJQueryUI': true
    'bRetrieve': true
    'iDisplayLength': 100
