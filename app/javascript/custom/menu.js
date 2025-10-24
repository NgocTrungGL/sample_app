document.addEventListener("turbo:load", function () {
  const account = document.querySelector("#account");
  const menu = document.querySelector("#dropdown-menu");

  if (account && menu) {
    account.addEventListener("click", function (event) {
      event.preventDefault();
      menu.classList.toggle("active");
    });
  }
});
