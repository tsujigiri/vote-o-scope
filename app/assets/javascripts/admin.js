(function ($) {
  $(function () {
    $('a.edit-reasoning').click(function (e) {
      e.preventDefault();
      $('.reasoning-input').hide()
      $(e.target).closest('tr').next().show()
    });
  });
})(jQuery);
