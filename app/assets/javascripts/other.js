$(() => {
  $('#img-upload').change((ev) => {
    console.log('CHANGE!');
    const el = ev.target;
    makeImgPreview(el);
  });

  const $imgPreview = $('#upload-img-preview');
  const $imgName = $('#upload-img-name');
  const hasFile = input => input.files && input.files[0];

  function makeImgPreview(el) {
    console.log(el.files);
    if (hasFile(el)) {
      const reader = new FileReader();
      reader.onload = e => {
        $imgPreview.attr({
          'src': e.target.result,
          'width': 30,
          'height': 30,
        });
        $imgName.text(el.files[0].name);
      }

      reader.readAsDataURL(el.files[0])
    }
  }
});
