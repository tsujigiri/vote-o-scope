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

  def answer_reasoning_modal_link(party, question)
    answer = party.answers.where(question_id: question.id).first
    html_id = 'party-reasoning-modal'
    html_class = (answer ? 'reasoning-present' : 'reasoning-absent')
    link_to("reasoning", '#', class: html_class, id: html_id)
  end
end
