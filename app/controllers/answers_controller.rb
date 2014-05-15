class AnswersController < ApplicationController
  load_and_authorize_resource
  respond_to :json, only: :index

  def index
    @parties = Party.all
    @questions = Question.all
    @answers = Answer.all_with_missing.reduce({}) do |m,a|
      m[[a.party_id, a.question_id]] = a
      m
    end
  end

  def new
    @answer = Answer.new
  end

  def edit
  end

  def create
    @answer = Answer.create(answer_params)
    respond_with @answer, location: answers_path
  end

  def update
    answers_params.keys.each do |key|
      _, party_id, _, question_id = key.split('_')
      answer = Answer.find_or_initialize_by(question_id: question_id.to_i,
                                            party_id: party_id.to_i)
      answer.update!(answers_params[key])
    end
    redirect_to answers_path
  end

  def destroy
    @answer.destroy
    respond_with @answer, location: answers_path
  end

  private

  def answers_params
    params.require(:answers).permit!
  end
end
