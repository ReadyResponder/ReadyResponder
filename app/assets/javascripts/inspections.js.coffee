jQuery ->
  $('#inspections').dataTable
    columnDefs: [
                  ## https://datatables.net/extensions/responsive/priority
                  { orderable: false, targets: [3, 4, 5] },
                ]

jQuery ->
  $('#item_inspections').dataTable
    columnDefs: [
                  ## https://datatables.net/extensions/responsive/priority
                  { orderable: false, targets: [-1] },
                ]
