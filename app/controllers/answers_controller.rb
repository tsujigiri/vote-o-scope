class AnswersController < ApplicationController
  load_and_authorize_resource
  respond_to :json, only: :index

  def index
    @parties = Party.all
    @questions = Question.all
    respond_to do |format|
      format.html do
        @answers = Answer.all_with_missing.reduce({}) do |m,a|
          m[[a.party_id, a.question_id]] = a
          m
        end
      end
      format.json { render json: Answer.all_with_missing }
    end
  end

  def update
    answers_params.keys.each do |key|
      _, party_id, _, question_id = key.split('_')
      answer = Answer.find_or_initialize_by(question_id: question_id,
                                            party_id: party_id)
      answer.update!(answers_params[key])
    end
    redirect_to answers_path
  end

  private

  def answers_params
    params.require(:answers).permit!
  end
end
