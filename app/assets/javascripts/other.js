$(() => {
  $('#img-upload').change(ev => {
    const el = ev.target;
    makeImgPreview(el);
  });

  const $imgPreview = $('#upload-img-preview');
  const $imgName = $('#upload-img-name');
  const hasFile = input => input.files && input.files[0];

  function makeImgPreview(el) {
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

      reader.readAsDataURL(el.files[0]);
    }
  }
});

$(() => {
  $('.js-deck-row').click(ev => {
    const [ $target, $self ] = [ $(ev.currentTarget), $(ev.target) ];
    const notLink = !$self.is('a, a *');
    if (notLink) {
      location.href = $target.attr('data-url');
    }
  });
});
