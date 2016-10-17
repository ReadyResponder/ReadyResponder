# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

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
