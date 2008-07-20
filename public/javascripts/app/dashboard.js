function dashboard () {
  $("span.logout").click(function() { logout(); });
  $("body").append($("<div/>").attr("id","events"));
  display_events();
}

function display_events() {
  $.getJSON("/events", null, function(events) {
    $("#events").empty();
    $("#events").append($.pageTemplates["events"](events));
    $("#events div.event").click(function() { display_event($(this).attr("event_id")); });
  });
}

function display_event (event_id) {
  $.getJSON("/events/" + event_id, null, function(event) {
    $("body").append(
      $("<div/>").attr("id","event-" + event.id).append(
        $.pageTemplates["event"](event)
      )
    );
  });
}
