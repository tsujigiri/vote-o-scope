(function ($) {
  $(function () {
    $('#party-reasoning-modal').click(function (e) {
      e.preventDefault();
      Modal.open({ content: $('#party-reasoning-modal-content').html() });
    });
  });
})(jQuery);
