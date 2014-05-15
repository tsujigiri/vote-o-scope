(function ($) {
  $(function () {
    $('a.edit-reasoning').click(function (e) {
      e.preventDefault();
      $(e.target).closest('tr').next().show()
    });
  });
})(jQuery);
