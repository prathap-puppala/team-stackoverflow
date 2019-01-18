class QuestionsController < ApplicationController

	def index
		@questions = Question.all
	end

	def show
		@question = Question.find(params[:id])
		@answers = @question.answers
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
  	@tags=params["hidden-tags"].split(",")
  	@tagid = nil
  	@question.save
  	for i in @tags
  		@tagid=Tag.find_by(name: i)
  		if !(@tagid)
  			@tagid = Tag.create(name: i)
		end
		@question.question_tags.create!(tag_id: @tagid.id)
	end
	flash[:success] = "Question added successfully"
  	redirect_to root_path
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
