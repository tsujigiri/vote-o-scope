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

  def answer_reasoning_edit_link(party, question)
    answer = answer(party, question)
    html_class = 'edit-reasoning '
    if answer.try(:reasoning).present?
      html_class << 'reasoning-present'
    else
      html_class << 'reasoning-absent'
    end
    link_to("reasoning", '#', class: html_class)
  end

  def answer_radio_button(party, question, answer, existing_answer)
    html_name = answer_key(party, question, 'answer')
    html = '<td class="center">'
    html << radio_button_tag(html_name, answer, answer == existing_answer)
    html << '</td>'
    html
  end

  def answer_radio_buttons(party, question)
    answer = answer(party, question).answer
    html = ""
    html << answer_radio_button(party, question, :agree, answer)
    html << answer_radio_button(party, question, :neutral, answer)
    html << answer_radio_button(party, question, :disagree, answer)
    raw(html)
  end

  def answer_key(party, question, field)
    "answers[party_#{party.id}_question_#{question.id}][#{field}]"
  end

  def answer_reasoning_textarea(party, question)
    answer = answer(party, question)
    raw(text_area_tag(answer_key(party, question, 'reasoning'),
                      answer.reasoning,
                      cols: 50, rows: 3))
  end

  def answer(party, question)
    @answers[[party.id, question.id]]
  end
end
