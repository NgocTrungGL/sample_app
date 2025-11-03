$(document).on("turbo:load", function () {
  $("#micropost_image").on("change", function () {
    const sizeInMegabytes = this.files[0].size / 1024 / 1024;

    if (sizeInMegabytes > 5) {
      $(this).val("");

      const alertHtml = `
        <div class="alert alert-warning alert-dismissible fade show" role="alert">
          Maximum file size is 5MB. Please choose a smaller file.
          <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
      `;
      $("#image-upload-container").prepend(alertHtml);
    }
  });
});
