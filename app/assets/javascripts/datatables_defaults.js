/* Set default DataTable options */
/* https://datatables.net/examples/advanced_init/defaults.html */
/* https://datatables.net/reference/option/ */

$.extend( true, $.fn.dataTable.defaults, {
  "dom": "fr<'event-table-info't>ip",
  scrollCollapse: true,         // https://datatables.net/reference/option/scrollCollapse
  scrollY: '50vh',              // https://datatables.net/examples/basic_init/scroll_y_dynamic.html
  responsive: true,             // https://datatables.net/extensions/responsive/priority
  paging: false,                // paging
  info: false,                  // showing X of Y entries
  pagingType: "full_numbers",
  retrieve: true,
  pageLength: 100,
  searching: true,
  lengthChange: false
} );

/* Initialize all DataTables of class generic_datatable */
/* https://datatables.net/examples/basic_init/multiple_tables.html */

$(document).ready(function() {
  $('table.generic_datatable').DataTable({
  });
} );
