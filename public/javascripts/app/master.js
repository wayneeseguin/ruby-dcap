$.app = $.app || {}; // Data buffering object.

$(document).ready(function() { 
  // Initialize templates
  jQuery(function($) {
    $.pageTemplates = {};
    $("script[type=text/x-jquery-template]").each(function() {
      $.pageTemplates[this.title] = $.makeTemplate(this.innerHTML, "<%", "%>");
    });
  });
  
  dashboard();
});

function logout() {
  answer = confirm("Are you sure you wish to logout?");
  if(answer) {
    window.location = "/auth/logout";
  }
}

// Fetch the specified entities and then trigger the specified callback.
function get_entities (entity_class,callback) {  
  $.getJSON("/" + entity_class, null, function(entities) {
    $.app[entity_class] = entities;
    callback(entities);
  });
}
