$.extend( true, $.fn.dataTable.defaults, {
  pagingType: "full_numbers",
  retrieve: true,
  pageLength: 100,
  searching: false,
  /* ordering: false, */
} );

$(document).ready(function() {
    $('table.generic_datatable').DataTable();
} );
