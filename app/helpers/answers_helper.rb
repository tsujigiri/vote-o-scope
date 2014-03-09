module AnswersHelper
  def options_for_answer_answer
    Answer::ANSWERS.map {|answer| [t("answers.answers.#{answer}"), answer] }
  end

  def options_for_answer_party
    Party.all.map {|party| [party.name, party.id] }
  end

  def options_for_answer_question
    Question.all.map {|question| [question.short, question.id] }
  end
end
