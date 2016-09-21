jQuery ->
  $('#repairs').dataTable
    columnDefs: [
                  ## https://datatables.net/extensions/responsive/priority
                  { orderable: false, targets: [-1] },
                ]

jQuery ->
  $('#item_repairs').dataTable
    columnDefs: [
                  ## https://datatables.net/extensions/responsive/priority
                  { orderable: false, targets: [-1] },
                ]
