var toggle = false;
var menu = document.getElementById("menu-ul");
function navBtn() {
  if (toggle === true) {
    document.getElementById('nav-btn').src  = '/assets/img/logo/logo_menu.svg';
  } else {
    document.getElementById('nav-btn').src  = '/assets/img/logo/logo_close.svg';
  }
  toggle = !toggle;

  menu.classList.toggle("active")
}
