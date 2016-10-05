jQuery ->
  $('#inspections').dataTable
    columnDefs: [
                  { orderable: false, targets: [4, 5] },
                ]

jQuery ->
  $('#item_inspections').dataTable
    ## https://datatables.net/examples/basic_init/scroll_y_dynamic.html
    scrollY: '20vh',
    columnDefs: [
                  { orderable: false, targets: [-1] },
                ]
