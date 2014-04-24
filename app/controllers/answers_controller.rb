class AnswersController < ApplicationController
  load_and_authorize_resource
  respond_to :json, only: :index
  respond_to :js, only: :show

  def index
    respond_with(@answers)
  end

  def show
    render layout: false
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
    @answer.update(answer_params)
    respond_with @answer, location: answers_path
  end

  def destroy
    @answer.destroy
    respond_with @answer, location: answers_path
  end

  private

  def answer_params
    params.require(:answer).permit!
  end
end
