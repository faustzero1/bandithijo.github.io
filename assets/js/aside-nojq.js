// https://stackoverflow.com/questions/5576893/how-to-toggle-hide-show-sidebar-div-using-jquery
var side = document.querySelector("#side");
var main = document.querySelector("#main");
var togg = document.querySelector("#toogle");
var width = window.innerWidth;

window.document.addEventListener("click", function() {

  if (side.clientWidth == 0) {
//    alert(side.clientWidth);
    side.style.width      = "200px";
    main.style.marginLeft = "200px";
    main.style.width      = (width - 200) + "px";
    togg.innerHTML        = "Min";
  } else {
//    alert(side.clientWidth);
    side.style.width      = "0";
    main.style.marginLeft = "0";
    main.style.width      = width + "px";
    togg.innerHTML        = "Max";
  }

}, false);
