// Keepalive sender for the Roadtrip Explorer GTM template.
// GTM's sandbox can only send an image pixel, which the browser may cancel when
// the page navigates right after an event. The template calls _rxSend when this
// script has loaded; the request is the same GET, sent so it survives navigation.
// Returns true when the request was handed to the browser, false to make the
// template fall back to its own pixel.
(function() {
  if (window._rxSend) {
    return;
  }

  window._rxSend = function(url) {
    if (typeof url !== 'string' || url.indexOf('https://events.explorerdash.com/') !== 0) {
      return false;
    }
    if (typeof window.fetch !== 'function') {
      return false;
    }

    try {
      window.fetch(url, {
        method: 'GET',
        mode: 'no-cors',
        credentials: 'omit',
        keepalive: true
      })['catch'](function() {});
      return true;
    } catch (e) {
      return false;
    }
  };
})();

(function() {
  // 1. Verify the configuration payload exists
  if (!window._rxConfig || !window._rxConfig.domains || !window._rxConfig.payload) {
    return;
  }

  var domains = window._rxConfig.domains;
  var payload = window._rxConfig.payload;

  // 2. Helper function to check if the clicked URL matches our domain list
  function isLinkedDomain(hostname) {
    if (!hostname) return false;
    var lowerHostname = hostname.toLowerCase();
    
    for (var i = 0; i < domains.length; i++) {
      var d = domains[i].toLowerCase();
      // Match exact domain or subdomains (e.g., 'company.com' matches 'jobs.company.com')
      if (lowerHostname === d || lowerHostname.indexOf('.' + d) === lowerHostname.length - ('.' + d).length) {
        return true;
      }
    }
    return false;
  }

  // 3. Attach a global click listener (Event Delegation)
  document.addEventListener('click', function(event) {
    // Traverse up the DOM tree in case the user clicked a <span> or <img> inside the <a> tag
    var target = event.target;
    while (target && target.tagName !== 'A') {
      target = target.parentNode;
    }

    // If no link was clicked, or it lacks an href, do nothing
    if (!target || !target.href) {
      return;
    }

    try {
      // Use the modern URL API to safely parse and manipulate the URL
      var url = new URL(target.href);

      // Ignore mailto:, tel:, or javascript: links
      if (url.protocol !== 'http:' && url.protocol !== 'https:') {
        return;
      }

      // 4. Check if the link goes to one of our target domains,
      // is NOT the current page's hostname, 
      // AND doesn't already have the payload attached
      if (
        isLinkedDomain(url.hostname) && 
        url.hostname !== window.location.hostname && 
        !url.searchParams.has('_rx_linker')
      ) {
        
        // Append our bundled payload without breaking existing parameters or hash fragments
        url.searchParams.set('_rx_linker', payload);
        var newHref = url.href;

        // 5. MITIGATION: Check if the new URL exceeds safe length limits
        if (newHref.length <= 2000) {
          target.href = newHref;
        } else {
          console.warn('Roadtrip Linker: URL exceeds safe limits. Skipping decoration to prevent 414 errors.');
        }
      }
    } catch (e) {
      // If the browser fails to parse the URL, fail silently and let the user navigate normally
    }
  });
})();