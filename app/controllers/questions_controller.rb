class QuestionsController < ApplicationController
  load_and_authorize_resource

  def new
    @question = Question.new
  end

  def edit
  end

  def update
    @question.update(question_attributes)
    respond_with @question, location: questions_path
  end

  def destroy
    @question.destroy
    respond_with @question, location: questions_path
  end

  private

  def question_attributes
    params.require(:question).permit!
  end
end
