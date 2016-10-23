# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

filterDivisionBasedOnDepartment = (department, division1, division2, reset = false) ->
  espaced_department = department.replace(/([ #;&,.+*~\':"!^$[\]()=>|\/@])/g, '\\$1')
  division1_options = $(division1).filter("optgroup[label='#{espaced_department}']").html()
  division2_options = $(division2).filter("optgroup[label='#{espaced_department}']").html()
  if division1_options
    $('#person_division1').html(division1_options)
  else
    $('#person_division1').empty()
  if division2_options
    $('#person_division2').html(division2_options)
  else
    $('#person_division2').empty()
  if reset
    $('#person_division1, #person_division2').prepend("<option value='' selected='selected'></option>")

jQuery ->
  $("#person_firstname").focus();
  $('#people').dataTable
    columnDefs: [
                  ## https://datatables.net/extensions/responsive/priority
                  { responsivePriority: 1, targets: [0, 1, 3, 6, 13] },
                  { visible: false, targets: [0, 2, 5]  },
                  { orderData: 1, targets: 1 }
                  { orderData: 3, targets: 1 }
                  { orderData: 5, targets: 6 }
                  { orderable: false, targets: 13 }
                ]
  department = $('#person_department :selected').text()
  division1 = $('#person_division1').html()
  division2 = $('#person_division2').html()
  filterDivisionBasedOnDepartment(department, division1, division2)
  $('#person_department').change ->
    department = $('#person_department :selected').text()
    filterDivisionBasedOnDepartment(department, division1, division2, true)
