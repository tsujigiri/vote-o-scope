class AnswersController < ApplicationController
  load_and_authorize_resource

  def new
    @answer = Answer.new
  end

  def edit
  end

  def update
    @answer.update(answer_attributes)
    respond_with @answer, location: answers_path
  end

  def destroy
    @answer.destroy
    respond_with @answer, location: answers_path
  end

  private

  def answer_attributes
    params.require(:answer).permit!
  end

end
