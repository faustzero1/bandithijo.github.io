$(window).load(function(){$(".spinner").fadeOut(),$("#preloader").delay(350).fadeOut("slow"),$("body").delay(350).css({overflow:"visible"})});

// If image url not respond
function imgError(image) {
  image.onerror = "";
  image.src = "/assets/img/logo/logo_blank.svg";
  return true;
}
