// Number of images in document:<script type="text/javascript">
//  document.write(document.images.length);
// </script>

  //document.write(document.images.length);

  for (var i=0; i<document.images.length; i++) {
    document.images[i].title = document.images[i].alt;
  }

