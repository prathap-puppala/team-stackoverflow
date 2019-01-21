# frozen_string_literal: true

# contains answer related functions
class AnswersController < ApplicationController
  before_action :authenticate
  before_action :check_user_has_teams
  before_action :set_answer, only: %i[show edit update destroy
                                      upvote downvote accept]
  before_action :check_same_user, only: %i[edit update destroy]

  def index
    @question = Question.find(params[:question_id])
    @answers = @question.answers.paginate(
      page: params[:page],
      per_page: 10
    )
  end

  def new
    @question = Question.find(params[:question_id])
    unless @question.can_be_answered?(current_user)
      flash[:danger] = 'You are not allowed to answer this question'
      redirect_to question_path(@question)
    end
    @answer = Answer.new
  end

  def show
    nil
  end

  def edit
    nil
  end

  def create
    @question = Question.find(params[:question_id])
    @answer = current_user.answers.new(params_require)
    @answer.question_id = @question.id
    if @answer.save
      @answer = current_user.answers.create(question_id: @question.id,
                                    description: params[:answer][:description])
      flash[:success] = 'Answer Submission successful'
      redirect_to question_answer_path(@question, @answer)
    else
      render 'new'
    end
  end

  def update
    return render 'edit' unless @answer.update(params_require)

    redirect_to question_answer_path(@question, @answer)
  end

  def destroy
    redirect_to question_path(@answer.question) if @answer.destroy
  end

  def upvote
    flash[:success] = 'Upvote success' if @answer.upvote(current_user)
    redirect_to question_path(@question)
  end

  def downvote
    flash[:success] = 'Downvote success' if @answer.downvote(current_user)
    redirect_to question_path(@question)
  end

  def accept
    flash[:danger] = 'You cannot perform this action' if
    @question.user_id != current_user.id && @question.status_code_id != 2

    flash[:success] = 'Answer marked as successfully' if @answer.accept
    redirect_to question_answers_path(params[:question_id])
  end

  def set_answer
    @question = Question.find(params[:question_id])
    @answer = Answer.find(params[:id])
  end

  private

  def params_require
    params.require(:answer).permit(:description)
  end

  def check_same_user
    return if same_user?(@answer.user_id)

    flash[:danger] = 'You dont have privileges to perform this action'
    redirect_to question_answers_path(@answer.question_id)
  end
end
