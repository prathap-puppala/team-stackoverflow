class Question < ApplicationRecord
	validates :subject, presence: true
	validates :description, presence: true
	validates :ans_upvote_score, presence: true, numericality: {only_integer: true }
	validates :ans_downvote_score, presence: true, numericality: {only_integer: true }

	has_many :answers, dependent: :destroy
	belongs_to :user
	has_many :question_tags, dependent: :destroy
	has_many :tags, :through => :question_tags
	has_many :question_accesses
	has_many :question_votes

	attr_accessor :current_user

	UP_DOWN_SCORE = [SiteSetting.new.getvalue('question_up_score'), SiteSetting.new.getvalue('question_down_score')].freeze

	def self.questions(user, question_id = nil)
		user_teams_list = User.teams_list(user)
		if question_id.present?
			questions = Question.where(id: question_id)
		else
			questions = Question.all
		end
		Question.new.access_list questions, user_teams_list
	end


	def access_list questions, user_teams_list
		questions.select do |question|
				@team_ids = (question.question_accesses.pluck(:team_id));
				((!(@team_ids & user_teams_list).empty?) && question[:status_code_id].to_i!=4)
			end
	end

	def answer_list questions, user_teams_list
		questions.select do |question|
				@team_ids = (question.question_accesses.select{|access| access[:answer_access]==true}.pluck(:team_id));
				((!(@team_ids & user_teams_list).empty?) && question[:status_code_id].to_i!=4)
			end
	end

	def vote_list questions, user_teams_list
		questions.select do |question|
				@team_ids = (question.question_accesses.select{|access| access[:vote_access]==true}.pluck(:team_id));
				((!(@team_ids & user_teams_list).empty?) && question[:status_code_id].to_i!=4)
			end
	end

 def can_we_display?
	 	question_ref = Question.where(id: self[:id])
	 	question = access_list question_ref,User.teams_list(user)
		self[:id].to_i == question[0][:id].to_i unless question.empty?
 end


 	def user_has_right_to_answer?
 	 	question_ref = Question.where(id: self[:id])
	 	question = answer_list question_ref,User.teams_list(user)
		self[:id].to_i == question[0][:id].to_i unless question.empty?

 	end

	def user_has_right_to_vote?
		question_ref = Question.where(id: self[:id])
		question = vote_list question_ref,User.teams_list(user)
		self[:id].to_i == question[0][:id].to_i unless question.empty?
	end

	def self.search key
		if key.present?
			Question.where('subject LIKE ?', "%#{key}%")
		end
	end

	def upvote
		self.question_votes.create!(up_down_vote: UP_DOWN_SCORE[0], user_id:current_user.id)
		Question.where(id: self.id).first.increment!(:up_vote_count,1)
	end

	def upvote_count
		self.question_votes.where(:up_down_vote=>1).count
	end


	def user_not_upvoted?
		self.question_votes.where(user_id: current_user.id).empty?
	end

	def user_not_downvoted?
		self.question_votes.where(user_id: current_user.id).empty?

	end

	def downvote_count
		self.question_votes.where(:up_down_vote=>-1).count

	end

	def downvote
		self.question_votes.create!(user_id:current_user.id, up_down_vote: UP_DOWN_SCORE[1])
		Question.where(id: self.id).first.increment!(:down_vote_count,1)
	end

end
