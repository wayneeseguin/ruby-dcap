// wycats' templating plugin
// (c) Yehuda Katz
// You may distribute this code under the same license as jQuery (BSD or GPL)
(function ($) {
  $.makeTemplate = function (template, begin, end) {
    var rebegin = begin.replace(/([\]{}[\\])/g, '\\$1');
    var reend = end.replace(/([\]{}[\\])/g, '\\$1');

    var code = "_context = _context || {}; with($.templates.helpers) { with (_context) {" +
      "var _result = '';" +
        template
          .replace(/[\t\r\n]/g, ' ')
          .replace(/^(.*)$/, end + '$1' + begin)
          .replace(new RegExp(reend + "(.*?)" + rebegin, "g"), function (text) {
            return text
              .replace(new RegExp("^" + reend + "(.*)" + rebegin + "$"), "$1")
              .replace(/\\/g, "\\\\")
              .replace(/'/g, "\\'")
              .replace(/^(.*)$/, end + "_result += (function() { try { return '$1' } catch(e) {return ''} })();" + begin);
          })
          .replace(new RegExp(rebegin + "=(.*?)" + reend, "g"), "try { if($1) _result += ($1); } catch(e) {}")
          .replace(new RegExp(rebegin + "(.*?)" + reend, "g"), ' $1 ')
          .replace(new RegExp("^" + reend + "(.*)" + rebegin + "$"), '$1') +
      "_result = _result.replace(/^\\s*/, '').replace(/\\s*$/, '');\n" + 
      "var ret = $(_result).data('template_obj', _context);\n" +
      "jQuery(document).trigger('template.created', [{ctx: _context, el: ret}]);\n" +
      "return _rawText ? _result : ret;" +
    "}}";
    
    try {
      return new Function("_context", "_rawText", code);
    } catch(e) {
      console.log("Error in:\n " + code)
    }
  };

  /* Some supplemental useful snippets that help build the widget system */
  $(function() {
    $.pageTemplates = {};
    $("script[type=text/x-jquery-template]").each(function() {
      $.pageTemplates[this.title] = $.makeTemplate(this.innerHTML, "<%", "%>");  
    });
  });
  
  $.fn.fn = function(name, func) {
    return this.each(function() {
      var meths = $(this).data("methods") || $.data(this, "methods", {});
      meths[name] = func;
    });
  };
  
  $.fn.invoke = function(name, rest) {
    meth = $(this).data("methods")[name];
    if(!meth)
      throw new Error("No method by the name of " + name + " exists on this element");
    else
      return meth.apply(this[0], Array.prototype.slice.call(arguments, 1, -1));
  };
    
  $.templates = {
    helpers: {
      partial: function(name, json) {
        return $.pageTemplates[name](json || {}, true);
      }
    }
  }
  
})(jQuery);
