filterLocationsBasedOnDepartment = (department, locations, reset = false) ->
  espaced_department = department.replace(/([ #;&,.+*~\':"!^$[\]()=>|\/@])/g, '\\$1')
  options = $(locations).filter("optgroup[label='#{espaced_department}']").html()
  if options
    $('#item_location_id').html(options)
  else
    $('#item_location_id').empty()
  if reset
    $('#item_location_id').prepend("<option value='' selected='selected'></option>")

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

  department = $('#item_department_id :selected').text()
  locations = $('#item_location_id').html()
  filterLocationsBasedOnDepartment(department, locations)
  $('#item_department_id').change ->
    department = $('#item_department_id :selected').text()
    filterLocationsBasedOnDepartment(department, locations, true)
