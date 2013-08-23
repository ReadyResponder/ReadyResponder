jQuery ->
  $("#event_description").focus();
  $(".training-controls").hide();
  $("#event_category").change ->
    temp = $("#event_category option:selected").text();
    if temp is "Training" 
      $(".training-controls").show()
    else
      $(".training-controls").hide()
    