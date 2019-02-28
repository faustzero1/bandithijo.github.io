var iOS = /^(iPhone|iPad|iPod)/.test(navigator.platform);
var safari = (navigator.vendor != null && navigator.vendor.match(/Apple Computer, Inc./) && navigator.userAgent.indexOf('Safari') != -1);

    function getParameterByName(name) {
        var match = RegExp('[?&]' + name + '=([^&]*)').exec(window.location.search);
        return match && decodeURIComponent(match[1].replace(/\+/g, ' '));
    }

    function createCookie(name,value,days) {
        var expires = "";
        if (days) {
            var date = new Date();
            date.setTime(date.getTime() + (days*24*60*60*1000));
            expires = "; expires=" + date.toUTCString();
        }
        document.cookie = name + "=" + value + expires + "; path=/";
    }
    function readCookie(name) {
        var nameEQ = name + "=";
        var ca = document.cookie.split(';');
        for(var i=0;i < ca.length;i++) {
            var c = ca[i];
            while (c.charAt(0)==' ') c = c.substring(1,c.length);
            if (c.indexOf(nameEQ) == 0) return c.substring(nameEQ.length,c.length);
        }
        return null;
    }
    function eraseCookie(name) {
        createCookie(name,"",-1);
    }

    if (iOS) {
        if (window.navigator.standalone) {
            $('a').each( function() {
                if($(this).attr('href')) $(this).attr('href',$(this).attr('href') + '?install-to-homescreen-dismissed=true');
            });
        }
        //dismiss forever
        if (getParameterByName('install-to-homescreen-dismissed')=='true') createCookie('install-to-homescreen-dismissed','true',9999);
    }
    if(readCookie('install-to-homescreen-dismissed')=='true') {
        //do nothing... message dismissed... nag again after the set period
    } else {
        if(iOS && safari) {
            $('body').append("<div id='install-to-homescreen'><span>We would love you to install this website as a mobile app. <br />Find the share button in your browser (<img src=\"/img/share.svg\" class=\"share_img\" />) and select the plus (<img src=\"/img/addtohomescreen.svg\" class=\"addtohomescreen_img\" />) to install.</span><a id='dismiss-install-to-homescreen' class='btn btn-primary btn-sm' onclick=\"createCookie('install-to-homescreen-dismissed','true',1); $('#install-to-homescreen').hide();\">Dismiss</a></div>");
            $('#install-to-homescreen').show();
        }
    }

    $('head').append('<meta name="apple-mobile-web-app-capable" content="yes" />');
