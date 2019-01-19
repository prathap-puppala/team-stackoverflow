class Question < ApplicationRecord
	has_many :answers, dependent: :destroy
	belongs_to :user
	has_many :question_tags, dependent: :destroy
	has_many :tags, :through => :question_tags
	has_many :question_accesses
	#has_many :votes, :as => :votable
	has_many :question_votes
	#acts_as_votable
	attr_accessor :current_user
	

	def upvote
		self.question_votes.create!(up_down_vote: 1,user_id:current_user.id)
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
		self.question_votes.create!(user_id:current_user.id,up_down_vote:-1)
	end

end

# @question
# if not @question.user_aleready_upvoted?
#	@question.up_vote
# 

