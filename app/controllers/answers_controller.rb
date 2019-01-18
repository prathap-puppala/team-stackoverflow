class AnswersController < ApplicationController
  def index
    @question = Question.find(params[:question_id])
  	@answers = @question.answers.all

  end
  def new
  	@answer = Answer.new
    @question = Question.find(params[:question_id])
  end

  def show
    @question = Question.find(params[:question_id])
    @answer = Answer.find(params[:id])
    #@answer = @question.answers
  end

   def edit
		@answer = Answer.find(params[:id])
    @question = @answer.question
	end
	
  def create
  	@answer = Answer.new(params_require)
    @answer = current_user.answers.new(params_require)
    @question = Question.find(params[:question_id])
    @answer.question_id = @question.id
    #@answer.user_id = session[:user_id]
    #@answer.question_id = question_id
  	if @answer.save
  		redirect_to question_answer_path(@question,@answer)
  	else
  		render 'new'
  	end
  end

  def update
		@answer = Answer.find(params[:id])
    @question = @answer.question
		if @answer.update(params_require)
			redirect_to question_answer_path(@question,@answer)
		else
			render 'edit'
		end
	end
	def destroy
		@answer = Answer.find(params[:id])
		@answer.destroy
		redirect_to question_path(@answer.question)
	end
  private
  def params_require
  	params.require(:answer).permit(:description)
  	#params.require(:login).permit(:email,:password)
  end
end
