// for now, this project depends on jQuery but the frontend is not complex
// and so it could probably be written without jQuery...

if (window.jQuery) {
  window.jQuery(function(){
    var setItem = function(name, value) {
      if(typeof(Storage) !== "undefined") {
        localStorage.setItem(name, value);
      }
    };

    var getItem = function(name, default_value) {
      if(typeof(Storage) !== "undefined") {
        return localStorage[name];
      } else {
        return default_value;
      }
    };

    var closeFaradayInspector = function(e) {
      setItem("rack_faraday_inspector_open", 'false');
      toggleFardayInspector();
    };

    var openFaradayInspector = function(e) {
      setItem("rack_faraday_inspector_open", 'true');
      toggleFardayInspector();
    };

    var closeAllRequests = function() {
      $('.faraday_inspector table .request').removeClass('open');
    };

    var showFaradayRequest = function(e) {
      var $el = $(this).next().find('.request');
      var isOpen = $el.hasClass('open');
      closeAllRequests();
      if (!isOpen) {
        $el.addClass('open');
      }
    };

    var toggleFardayInspector = function(e) {
      closeAllRequests();
      $('.faraday_inspector').toggleClass('minimized');
      $('.faraday_inspector').toggleClass('open');
    };

    if(getItem('rack_faraday_inspector_open', 'false') == 'true') {
      $('.faraday_inspector').removeClass('minimized');
      $('.faraday_inspector').addClass('open');
    }

    $('.faraday_inspector tr.event').click(showFaradayRequest);
    $('.faraday_inspector .close').click(closeFaradayInspector);
    $('.faraday_inspector .prompt').click(openFaradayInspector);
  });
}

if (!library)
  var library = {};

library.json = {
  replacer: function(match, pIndent, pKey, pVal, pEnd) {
    var key = "<span class='json-item json-key'>";
    var val = "<span class='json-item json-value'>";
    var str = "<span class='json-item json-string'>";
    var r = pIndent || '';
    if (pKey)
      r = r + key + pKey.replace(/[": ]/g, '') + '</span>: ';
    if (pVal)
      r = r + (pVal[0] == '"' ? str : val) + pVal + '</span>';
    var rval = r + (pEnd || '');
    return "<span class='json-line'>" + rval + "</span>";
  },
  prettyPrint: function(obj) {
    var jsonLine = /^( *)("[\w]+": )?("[^"]*"|[\w.+-]*)?([,[{])?$/mg;
    return JSON.stringify(obj, null, 3)
      .replace(/&/g, '&amp;').replace(/\\"/g, '&quot;')
      .replace(/</g, '&lt;').replace(/>/g, '&gt;')
      .replace(jsonLine, library.json.replacer);
  }
};
