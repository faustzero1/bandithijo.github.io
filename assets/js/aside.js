// aside
$(document).ready(function(){
  $('.hideAside').on('click',function(){
      $('aside').toggle('slide',function(){
          var visibilityStatus=$('aside').attr('data-visible');
          // alert(!visibilityStatus);
          $('aside').attr('data-visible',!visibilityStatus);
      });
  });
});

// article
(function(){
    var button = document.querySelector('.hideAside');
    var article = document.querySelector('.post');

    button.addEventListener('click', function(){
        article.classList.toggle('post-wide');
    });
})();

