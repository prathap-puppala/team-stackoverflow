class QuestionsController < ApplicationController

	def index
		@questions = Question.where.not(status_code_id: 4)
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
  		@teams=current_user.user_teams
		@tags=''
		@question.question_tags.each do |question_tag|
			@tags+='"'+question_tag.tag.name+'",'
		end
		@tags=@tags[0...-1]
	end


  def create
  	@question = current_user.questions.new(params_require)
  	@question.save
  	do_processing_for_tags_and_access
	flash[:success] = "Question added successfully"
  	redirect_to root_path
  end


  def update
		@question = Question.find(params[:id])
		@question.update(params_require)
		@questions = QuestionTag.where(question_id: @question.id)
		@questions.destroy_all
		@question_accesses = QuestionAccess.where(question_id: @question.id)
		@question_accesses.destroy_all
		do_processing_for_tags_and_access	  	
		flash[:success] = "Question updated successfully"
  		redirect_to question_path(@question)
  end

	def destroy
		@question = Question.find(params[:id])
		Question.where(id: @question.id).update_all(status_code_id: 4)
		flash[:success] = "Question deleted successfully"
		redirect_to questions_path
	end

  private
  def params_require
  	params.require(:question).permit(:subject,:description,:ans_upvote_score, :ans_downvote_score)
  end

  def do_processing_for_tags_and_access
  	if params.has_key?(:view_access)
  		for i in params[:view_access]
			@question.question_accesses.create!(team_id: i)
		end
	end

	if params.has_key?(:answer_access)
  		for i in params[:answer_access]
			QuestionAccess.where(question_id: @question.id, team_id: i).update_all(answer_access: true)
		end
	end

	if params.has_key?(:vote_access)
  		for i in params[:vote_access]
			QuestionAccess.where(question_id: @question.id, team_id: i).update_all(vote_access: true)
		end
	end

  	@tags=params["hidden-tags"].split(",")
  	@tagid = nil
  	for i in @tags
  		@tagid=Tag.find_by(name: i)
  		if !(@tagid)
  			@tagid = Tag.create(name: i)
		end
		@question.question_tags.create!(tag_id: @tagid.id)
	end
  end
end
