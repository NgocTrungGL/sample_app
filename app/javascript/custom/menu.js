import $ from "jquery";
window.$ = $;
window.jQuery = $;

$(document).on("turbo:load", function () {
  $("#account").on("click", function (e) {
    e.preventDefault();
    $("#dropdown-menu").toggleClass("active");
  });
});
