# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

jQuery ->
  $("#person_firstname").focus();
  $('#people').dataTable
    "columns": [
                  { "visible": false },
                  { "orderData": 1 },
                  { "visible": false },
                  { "orderData": 3 },
                   null,
                  { "visible": false },
                  { "orderData": 5 },
                  null,
                  null,
                  null,
                  null,
                  {"orderable" : false}]
