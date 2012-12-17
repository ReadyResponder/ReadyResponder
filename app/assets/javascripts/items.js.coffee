# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
jQuery ->
        $('#items').dataTable
          sPaginationType: "full_numbers"
          bJQueryUI: true
          iDisplayLength: 50
        $('#item_purchase_date').datepicker
          dateFormat: 'yy-mm-dd'
        $('#item_sell_date').datepicker
          dateFormat: 'yy-mm-dd'
