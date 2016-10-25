# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

drawChart = ->
  dataTable = new google.visualization.DataTable()
  dataTable.addColumn
    type: 'date'
    id: 'Date'
  dataTable.addColumn
    type: 'number'
    id: 'Count'
  $.ajax
    url: '/analytics/calendar_chart'
    type: 'GET'
    dataType: 'json'
    success: (data) ->
      data = data[0]
      for i of data
        dataTable.addRow [
          new Date(data[i].Date)
          data[i].Count
        ]
      chart = new (google.visualization.Calendar)($('#chartContainer')[0])
      options =
        title: 'Availability Chart'
        height: 350
      chart.draw dataTable, options
      return

loadGoogle = ->
  # define callback in load statement
  google.charts.load 'current',
    'packages': [ 'calendar' ]
    'callback': drawChart

if window.location.href.indexOf('calendar_chart') > -1
  loadGoogle()
