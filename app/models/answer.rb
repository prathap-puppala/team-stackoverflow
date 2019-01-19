class Answer < ApplicationRecord
	belongs_to :user
	belongs_to :question
	#has_many :votes, :as => :votable
	has_many :answer_votes
	#acts_as_votable
	attr_accessor :current_user


	def upvote
		self.answer_votes.create!(up_down_vote: 1,user_id:current_user.id)
	end

	def upvote_count
		self.answer_votes.where(:up_down_vote=>1).count
	end


	def user_not_upvoted?
		self.answer_votes.where(user_id: current_user.id).empty?
	end

	def user_not_downvoted?
		self.answer_votes.where(user_id: current_user.id).empty?

	end

	def downvote_count
		self.answer_votes.where(:up_down_vote=>-1).count

	end

	def downvote
		self.answer_votes.create!(user_id:current_user.id,up_down_vote:-1)
	end

end