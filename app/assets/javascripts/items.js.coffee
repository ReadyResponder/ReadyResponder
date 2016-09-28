jQuery ->
  $('form').on 'click', '.add_fields', (event) ->
    time = new Date().getTime()
    regexp = new RegExp($(this).data('id'), 'g')
    $(this).before($(this).data('fields').replace(regexp, time))
    event.preventDefault()

jQuery ->
  $('#items').dataTable
    columnDefs: [
                  ## https://datatables.net/extensions/responsive/priority
                  { responsivePriority: 1, targets: [0, 1, 5, 6 ] },
                  { responsivePriority: 2, targets: 4 },
                  { responsivePriority: 3, targets: 2 },
                  { responsivePriority: 4, targets: 3 },
                  { orderable: false, targets: -1 },
                ]
