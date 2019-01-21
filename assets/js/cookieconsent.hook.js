window.addEventListener("load", function(){
window.cookieconsent.initialise({
  "palette": {
    "popup": {
      "background": "#edeff5",
      "text": "#838391"
    },
    "button": {
      "background": "#4b81e8"
    }
  },
  "theme": "classic",
  "position": "bottom-right",
  "type": "opt-out",
  "content": {
    "message": "This website uses cookies for Google Analytics to track the number of visits to the site.",
    "dismiss": "Accept Cookies",
    "deny": "Decline Cookies"
  }

  //callback hook which is supposed to fire and give option to decline
 /* onInitialise: function (status) {
  var type = this.options.type;
  var didConsent = this.hasConsented();
  if (type == 'opt-in' && didConsent) {
    // enable cookies
  }
  if (type == 'opt-out' && !didConsent) {
    // disable cookies
  }
},

onStatusChange: function(status, chosenBefore) {
  var type = this.options.type;
  var didConsent = this.hasConsented();
  if (type == 'opt-in' && didConsent) {
    // enable cookies
  }
  if (type == 'opt-out' && !didConsent) {
    // disable cookies
  }
},

onRevokeChoice: function() {
  var type = this.options.type;
  if (type == 'opt-in') {
    // disable cookies
  }
  if (type == 'opt-out') {
    // enable cookies
  }
},
  */
  //end of cookie consent callback hook

})});
