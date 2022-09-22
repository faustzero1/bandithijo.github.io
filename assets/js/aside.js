// https://www.w3schools.com/howto/howto_js_toggle_hide_show.asp

// aside
function toggleShowHideSidebar() {
  var x = document.getElementById("sidebar-head");
  if (x.style.display === "none") {
    x.style.display = "block";
  } else {
    x.style.display = "none";
  }

  var x = document.getElementById("sidebar-tail");
  if (x.style.display === "none") {
    x.style.display = "block";
  } else {
    x.style.display = "none";
  }
}

// article
(function(){
    var button = document.querySelector('.hideAside');
    var article = document.querySelector('.post');

    button.addEventListener('click', function(){
      article.classList.toggle('post-wide');
    });
})();
