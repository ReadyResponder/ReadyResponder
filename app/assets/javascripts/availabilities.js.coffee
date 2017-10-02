jQuery ->
  $('#availabilities').dataTable
    order: [[0, 'desc'], [1, 'asc']],
    columnDefs: [
                  { visible: false, targets: [0] }
                ]
