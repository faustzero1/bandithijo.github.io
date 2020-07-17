window.onload = function() { // add window.onload here and set it euqal to a function
  var modalEle = document.querySelector(".modal");
  var modalImage = document.querySelector(".modal-content");
  Array.from(document.querySelectorAll(".myImg")).forEach(item => {
    item.addEventListener("click", event => {
        modalEle.style.display = "block";
        modalImage.src = event.target.src;
    });
  });

  // When the user clicks image or modal, close the modal
  document.querySelector(".modal").addEventListener("click", () => {
    modalEle.style.display = "none";
  });
}
