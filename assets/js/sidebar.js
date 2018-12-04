$(function () {
    // Set this variable with the height of your sidebar + header
    // var offsetPixels = 700;
    var offsetPixels = 240;

    $(window).scroll(function () {
        if ($(window).scrollTop() > offsetPixels) {
            $(".sidebar-body").css({
                "position": "fixed",
                "top": "3px",
                "width": "17.1%",
                "margin": "25px 20px 25px -20px",
                "padding": "5px 10px"
            });
        } else if ($(window.matchMedia("(max-width: 1177px)").matches).scrollTop() > offsetPixels) {
            $(".sidebar-body").css({
                "background": "yellow",
                "width": "auto",
                "position": "static"
            });
        } else if (window.matchMedia("(max-width: 1177px)").matches) {
            $(".sidebar-body").css({
                "background": "green",
                "width": "auto",
                "position": "static"
            });
        } else {
            $(".sidebar-body").css({
                "width": "91%",
                "background": "yellow",
                "position": "static",
            });
        }
    });
});
