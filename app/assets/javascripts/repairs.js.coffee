jQuery ->
  $('#repairs').dataTable
    columnDefs: [
                  { orderable: false, targets: [-1] },
                ]

jQuery ->
  $('#item_repairs').dataTable
    ## https://datatables.net/examples/basic_init/scroll_y_dynamic.html
    scrollY: '20vh',
    columnDefs: [
                  { orderable: false, targets: [-1] },
                ]
