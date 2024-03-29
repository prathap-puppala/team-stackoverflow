# frozen_string_literal: true

# This class contains methods related to Questions
class QuestionsController < ApplicationController
  before_action :authenticate
  before_action :check_user_has_teams
  before_action :set_question, only: %i[show edit update destroy upvote
                                        downvote check_same_user close]
  before_action :check_same_user, only: %i[edit update destroy close]

  def index
    @questions = Question.get_displayable(current_user).paginate(
      page: params[:page],
      per_page: 10
    )
  end

  def show
    unless @question.can_be_displayed?(current_user)
      flash[:danger] = 'You are not allowed to view this question'
      redirect_to root_path
    end
    @answers = Answer.get_displayable(@question.id).paginate(
      page: params[:page],
      per_page: 10
    )
  end

  def new
    @question = Question.new
    @tags = ''
    @teams = current_user.user_teams
  end

  def edit
    @tags = @question.tags
  end

  def create
    @question = current_user.questions.new(params_require)
    if @question.save
      if @question.process_tags(params)
        if @question.process_question_accesses(params)
          flash[:success] = 'Question added successfully'
          redirect_to root_path
        end
      else
        flash[:danger] = 'Minimum one tag is required'
      end
    else
      render 'new'
    end
  end

  def update
    @question.update(params_require)
    @question.destroy_tags
    @question.destroy_question_accesses
    if @question.process_tags(params)
      if @question.process_question_accesses(params)
        flash[:success] = 'Question updated successfully'
      end
    else
      flash[:danger] = 'Minimum one tag is required'
    end
    redirect_to question_path(@question)
  end

  def downvote
    flash[:success] = 'Downvote success' if @question.downvote(current_user)
    redirect_to question_path(@question)
  end

  def upvote
    flash[:success] = 'Upvote success' if @question.upvote(current_user)
    redirect_to question_path(@question)
  end

  def close
    flash[:success] = 'Question Closed successfully' if @question.close
    redirect_to questions_path
  end

  def destroy
    flash[:success] = 'Question deleted successfully' if @question.destroy
    redirect_to questions_path
  end

  def set_question
    @question = Question.find(params[:id])
  end

  private

  def params_require
    if params[:all].to_i == 1
      params[:view_access] = current_user.team_ids
      params[:answer_access] = current_user.team_ids
      params[:vote_access] = current_user.team_ids
    end
    params.require(:question).permit(:subject,
                                     :description,
                                     :team_id)
  end

  def check_same_user
    return if same_user?(@question.user_id)

    flash[:danger] = 'You dont have privileges to perform this action'
    redirect_to questions_path
  end
end
