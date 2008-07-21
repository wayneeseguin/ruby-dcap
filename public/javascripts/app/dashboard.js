function dashboard () {
  $("span.logout").click(logout);
  $("div#right_column").append($("<div/>").attr("id","events"));
  display_events();
}

function display_events() {
  $.getJSON("/events", null, function(events) {
    $("div#events").empty();
    $("div#events").append($.pageTemplates["events"](events));
    $("div#events li.event").click(function() { display_event($(this).attr("event_id")); });
  });
}

function display_event (event_id) {
  $.getJSON("/events/" + event_id, null, function(event) {
    $("div#left_column").empty().append(
      $("<div/>").attr("id","event-" + event.id).append(
        $.pageTemplates["event"](event)
      )
    );
    display_sessions_for_event(event_id);
  });
}

function display_sessions_for_event(event_id) {
  $.getJSON("/events/" + event_id + "/sessions", null, function(sessions) {
    $("div#event-" + event_id).append(
      $("<div/>").attr("id","sessions").append(
        $.pageTemplates["sessions"](sessions)
      )
    );
  });
}
