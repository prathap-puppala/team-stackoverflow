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
  	@tags = ""
  	@teams=current_user.user_teams
  end

  def edit
		@question = Question.find(params[:id])
		@tags=''
		@question.question_tags.each do |question_tag|
			@tags+='"'+question_tag.tag.name+'",'
		end
		@tags=@tags[0...-1]
	end

  def create
  	@question = current_user.questions.new(params_require)
  	@question.save
  	@tags=params["hidden-tags"].split(",")
  	@tagid = nil
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
		@question.update(params_require)
		@questions = QuestionTag.where(question_id: @question.id)
		@questions.destroy_all
		@tags=params["hidden-tags"].split(",")
		@tagid = nil
		for i in @tags
  		@tagid=Tag.find_by(name: i)
  		if !(@tagid)
  			@tagid = Tag.create(name: i)
			end
			@question.question_tags.create!(tag_id: @tagid.id)
	  end
		flash[:success] = "Question updated successfully"
  	redirect_to question_path(@question)
  end

	def destroy
		@question = Question.find(params[:id])
		@question.destroy
		flash[:success] = "Question deleted successfully"
		redirect_to questions_path
	end
  private
  def params_require
  	params.require(:question).permit(:subject,:description)
  end
end
