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
    var parties = _.map(window.VoteOScope.parties, function (party) {
      party = _.clone(party);
      party.consensusPercentage = parseInt(consensusPercentage(party), 10);
      return party;
    });
    parties = _.sortBy(parties, function (p) { return p.consensusPercentage; });
    parties = parties.reverse();
    var context = {
      parties: parties,
    }
    return HandlebarsTemplates['results/top_list'](context);
  };

  var detailedResults = function () {
    var context = {
      parties: window.VoteOScope.parties,
      questions: _.map(window.VoteOScope.questions, buildDetailedResultsContext),
    }
    var $details = $(HandlebarsTemplates['results/details'](context));
    $details.on('click', '.vote-o-scope-party-answer-link', showPartyReasoning);
    return $details;
  };

  var showPartyReasoning = function (e) {
    e.preventDefault();
    var answerId = $(e.target).attr('data-answer-id');
    Modal.open({
      ajaxContent: '/answers/' + answerId,
      width: '50%', // Can be set to px, em, %, or whatever else is out there.
      height: '50%',
      //hideclose: true, // Hides the close-modal graphic
      //closeAfter: 10 // Define this number in seconds.
    });
  }

  var buildDetailedResultsContext = function (question, i) {
    question = _.clone(question);
    question.partiesAnswers = _.map(window.VoteOScope.parties, function (party) {
      var partyAnswer = _.clone(_.first(_.where(party.answers, { question_id: question.id })));
      var userAnswer = window.VoteOScope.userAnswers[i];
      if (userAnswer && userAnswer == 'neutral') {
        partyAnswer.matchClass = 'neutral';
      } else if (userAnswer && userAnswer == partyAnswer.answer) {
        partyAnswer.matchClass = 'match';
      } else if (userAnswer && userAnswer != partyAnswer.answer) {
        partyAnswer.matchClass = 'no-match';
      }
      return partyAnswer;
    });
    return question;
  };

  var storeAnswer = function (answer) {
    window.VoteOScope.userAnswers[currentQuestionIndex] = answer;
  }

  var consensusPercentage = function (party) {
    var consensus = _.map(window.VoteOScope.userAnswers, function (answer, i) {
      return party.answers[i].answer == answer;
    });
    var total = _.reduce(consensus, function (memo, item) {
      return memo + { true: 1, false: 0 }[item];
    }, 0);
    return total / consensus.length * 100;
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
