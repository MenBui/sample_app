$('#micropost_image').bind('change', function () {
  var sizeInMegabytes = this.files[0].size/1024/1024;
  if (size_in_megabytes > 5) {
    alert(I18n.t 'maximun_file');
  }
});
