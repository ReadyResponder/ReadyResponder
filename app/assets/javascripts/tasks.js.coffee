jQuery ->
  $('#tasks').dataTable
    columnDefs: [
                  { orderable: false, targets: [-1] },
                ]

jQuery ->
  $('#event_tasks').dataTable
    ## https://datatables.net/examples/basic_init/scroll_y_dynamic.html
    scrollY: '20vh',
    columnDefs: [
                  { orderable: false, targets: [-1] },
                ]
