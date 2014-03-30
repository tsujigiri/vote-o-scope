$(function () {
  var currentQuestionIndex = 0;

  var updateContent = function (newContent) {
	$('#container').html(newContent);
  };

  var answerQuestion = function (e) {
	e.preventDefault();
	storeAnswer();
	showNextQuestion(e);
  }

  var renderQuestion = function (q) {
	$question = $(HandlebarsTemplates['questions/show'](q));
	$question.find('.answer').click(answerQuestion);
	updateContent($question);
  };

  var showNextQuestion = function () {
	var nextQuestion = window.VoteOScope.questions[currentQuestionIndex+1];
	if (nextQuestion) {
	  renderQuestion(nextQuestion);
	  currentQuestionIndex = currentQuestionIndex+1;
	} else {
	  showResults();
	}
  }


  var showResults = function () {
	context = {
	  parties: window.VoteOScope.parties,
	}
	updateContent(HandlebarsTemplates['results/top_list'](context));
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

  renderQuestion(window.VoteOScope.questions[0]);


  $.getJSON('/parties', function (json) {
	window.VoteOScope.parties = json;
  });
  $.getJSON('/answers', function (json) {
	window.VoteOScope.partyAnswers = json;
  });
})
