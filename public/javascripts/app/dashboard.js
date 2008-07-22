function dashboard () {
  $("span.logout").click(logout);
  $("div#right_column").append($("<div/>").attr("id","events"));
  display_events();
}

function display_events() {
  $.getJSON("/events", null, function(events) {
    $("div#events").empty().append(
        $.pageTemplates["events"](events)
    );
    $("div#events li.event").click(function() { 
      display_event($(this).attr("event_id")); 
    });
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
        $.pageTemplates["event_sessions"](sessions)
      )
    );
    $("div.session h3").click(function() { 
      display_session($(this).attr("session_id"));
    });    
  });
}

function display_session(session_id) {
  $.getJSON("/sessions/" + session_id, null, function(session) {
    $("div#left_column").empty().append(
      $("<div/>").attr("id", "session-" + session.id).append(
        $.pageTemplates["session"](session)
      )
    );
    $.getJSON("/sessions/" + session_id + "/comments", null, function(comments) { 
      $("div#comments").append(
        $.pageTemplates["session_comments"](comments)
      )
    });
  });
}