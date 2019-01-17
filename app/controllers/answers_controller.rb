class AnswersController < ApplicationController
  def index
    #user = User.find.first
    question = Question.find(params[:question_id])
  	@answer = question.answers.all

  end
  def new
  	@answer = Answer.new
    @question = Question.find(params[:question_id])
  end

  def show
    @question = Question.find(params[:question_id])
    @answer = question.answers.all
   # @question = Question.all
  	#@answer = Answer.find(params[:id])
  end
   def edit
		@answer = Answer.find(params[:id])
	end
	
  def create
  	@answer = Answer.new(params_require)
    @answer = current_user.answers.new(params_require)
    @answer.question_id = Question.find(params[:question_id]).id
    #@answer.user_id = session[:user_id]
    #@answer.question_id = question_id
  	if @answer.save
  		render 'show'
  	else
  		render 'new'
  	end
  end
  def update
		@answer = Answer.find(params[:id])
		if @answer.update(params_require)
			redirect_to @answer
		else
			render 'edit'
		end
	end
	def destroy
		@answer = Answer.find(params[:id])
		@answer.destroy
		render 'new'
	end
  private
  def params_require
  	params.require(:answer).permit(:description)
  	#params.require(:login).permit(:email,:password)
  end
end
