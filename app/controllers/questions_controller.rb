class QuestionsController < ApplicationController
  load_and_authorize_resource

  def index
  end

  def answer
  end

  def new
    @question = Question.new
  end

  def edit
  end

  def create
    @question.save
    respond_with @question, location: questions_path
  end

  def update
    @question.update(question_params)
    respond_with @question, location: questions_path
  end

  def destroy
    @question.destroy
    respond_with @question, location: questions_path
  end

  private

  def question_params
    params.require(:question).permit!
  end
end
