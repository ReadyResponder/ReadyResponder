// Calendar implementation for events, refer to https://docs.dhtmlx.com/scheduler/index.html
scheduler.config.readonly = true;
scheduler.config.show_loading = true;
scheduler.config.xml_date = "%Y-%m-%d %h:%i";
scheduler.attachEvent("onTemplatesReady", function(){
  scheduler.templates.xml_date = function(dateString){
   return new Date(dateString)
  };

  scheduler.templates.xml_format = function(date){
    return date.toISOString();
  };
});

scheduler.init('index-event-scheduler', new Date(),"month");
scheduler.load("events.json", "json");
scheduler.attachEvent("onClick", function (id, e){
       window.location.href = `events/${id}`;
       return true;
  });
