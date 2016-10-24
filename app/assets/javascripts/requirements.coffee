jQuery ->
  $('#requirements').dataTable
    columnDefs: [
                  { orderable: false, targets: [-1] },
                ]

jQuery ->
  $('#task_requirements').dataTable
    ## https://datatables.net/examples/basic_init/scroll_y_dynamic.html
    scrollY: '20vh',
    columnDefs: [
                  { orderable: false, targets: [-1] },
                ]
