(function ($) {

  var currentQuestionIndex = 0;

  var updateContent = function (newContent) {
	$('#container').html(newContent);
  };

  var answerQuestion = function (e) {
	e.preventDefault();
	var answer = $(e.target).attr('data-answer');
	if (answer) {
	  storeAnswer(answer);
	}
	showNextQuestion(e);
  }

  var renderQuestion = function (q) {
	$question = $(HandlebarsTemplates['questions/show'](q));
	$question.on('click', '.answer', answerQuestion);
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
	var content = [];
	content.push(topList());
	content.push(detailedResults());
	updateContent(content);
  };

  var topList = function () {
	var partiesWithConensus = _.map(window.VoteOScope.parties, function (party) {
	  party.conensusPercentage = consensusPercentage(party);
	  return party;
	});
	var context = {
	  parties: partiesWithConensus,
	}
	return HandlebarsTemplates['results/top_list'](context);
  };

  var detailedResults = function () {
	var questions = _.map(window.VoteOScope.questions, function (q) {
	  q.partiesAnswers = _.map(window.VoteOScope.parties, function (p) {
		var answer = _.first(_.where(p.answers, { question_id: q.id }));
		return (answer ? answer.answer : 'neutral');
	  });
	  return q;
	});
	var context = {
	  parties: window.VoteOScope.parties,
	  questions: questions,
	}
	return HandlebarsTemplates['results/details'](context);
  };

  var storeAnswer = function (answer) {
	window.VoteOScope.userAnswers[currentQuestionIndex] = answer;
  }

  var consensusPercentage = function (party) {
	var consensus = _.map(window.VoteOScope.userAnswers, function (answer, i) {
	  return party.answers[i] == answer;
	});
	var total = _.reduce(consensus, function (memo, item) {
	  return memo + { true: 1, false: 0 }[item];
	}, 0);
	return total / consensus.length;
  };

  $(function () {
	renderQuestion(window.VoteOScope.questions[0]);

	$.getJSON('/parties', function (json) {
	  window.VoteOScope.parties = json;
	});

	$.getJSON('/answers', function (json) {
	  window.VoteOScope.partyAnswers = json;
	});
  })

})(jQuery);
