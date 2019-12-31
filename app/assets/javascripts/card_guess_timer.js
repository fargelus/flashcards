$(() => {
  const $guessTime = $('#guess_time');

  setInterval(() => {
    const prev = +$guessTime.val();
    $guessTime.val(prev + 1);
  }, 1000);
});
