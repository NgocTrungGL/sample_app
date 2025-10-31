$(document).on("turbo:load", function () {
  $("#micropost_image").on("change", function () {
    const sizeInMegabytes = this.files[0].size / 1024 / 1024;

    if (sizeInMegabytes > 5) {
      alert("Maximum file size is 5MB. Please choose a smaller file.");
      $(this).val(""); // xóa file đã chọn
    }
  });
});
