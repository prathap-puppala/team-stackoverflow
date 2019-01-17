class QuestionsController < ApplicationController

	def index
		@user = Question.all
	end
	def show
		@question = Question.all
	end
  def new
  	@question = Question.new
  end
  def edit
		@question = Question.find(params[:id])
	end
  def create
  	#@question = Question.new(params_require)
  	@question = current_user.questions.new(params_require)
  	if @question.save
  		redirect_to @question
  	else
  		render 'new'
  	end
  end
  def update
		@question = Question.find(params[:id])
		if @question.update(params_require)
			redirect_to @question
		else
			render 'edit'
		end
	end
	def destroy
		@question = Question.find(params[:id])
		@question.destroy
		render 'new'
	end
  private
  def params_require
  	params.require(:question).permit(:subject,:description)
  end
end
