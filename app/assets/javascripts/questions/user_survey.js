$(function () {
  var currentQuestionIndex = 0;
  var $short = $('#question-short');
  var $long = $('#question-long');

  var showNextQuestion = function () {
	var nextQuestion = window.VoteOScope.questions[currentQuestionIndex+1];
	if (nextQuestion) {
	  $short.text(nextQuestion.short);
	  $long.text(nextQuestion.long);
	  currentQuestionIndex = nextQuestion.id;
	} else {
	  renderResult();
	}
  }

  var renderResult = function () {
	var topList = renderTopList();
	$('#container').html(topList);
  };

  var renderTopList = function () {
	$.each(window.VoteOScope.questions, function (i, q) {
	  $table = $('<table>');
	  $.each(window.VoteOScope.parties, function (j, party) {
		var $row = $('<tr>');

		var $party = $('<td>');
		$party.text(party.name);
		$row.append($party);

		var $percentage = $('<td>');
		var $percentageBar = $('<div>');
		$percentageBar.addClass('percentage-bar');
		$percentageBar.css('width', 10);
		$percentage.append($percentageBar);
		$row.append($percentage);

		var $percentageText = $('<td>');
		$percentageText.text(10 + '%');
		$row.append($percentageText);

		$table.append($row);
	  });
	});
	return $table;
  }

  var storeAnswer = function (e) {
	var $a = $(e);
	var answer = {
	  '#yes': true,
	  '#no': false,
	}[$a.attr('href')];
	if (!answer) return null;
	var questionId = $a.attr('data-question-id');
	window.VoteOScope.userAnswers[questionId] = answer;
  }

  $('.answer').click(function (e) {
	storeAnswer();
	showNextQuestion(e);
  });

  $.getJSON('/parties', function (json) {
	window.VoteOScope.parties = json;
  });
  $.getJSON('/answers', function (json) {
	window.VoteOScope.partyAnswers = json;
  });
})
