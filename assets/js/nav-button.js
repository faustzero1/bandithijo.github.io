var toggle = false;
function navBtn() {
    if (toggle === true) {
        document.getElementById('nav-btn').src  = '/assets/img/logo/logo_menu.svg';
    } else {
        document.getElementById('nav-btn').src  = '/assets/img/logo/logo_close.svg';
    }
    toggle = !toggle;
}
