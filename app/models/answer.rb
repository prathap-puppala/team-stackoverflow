class Answer < ApplicationRecord
	validates :description, presence: true

	belongs_to :user
	belongs_to :question
	has_many :answer_votes
	attr_accessor :current_user


	def self.answers(qsn_id)
		Answer.where(question_id: qsn_id)
	end


def up_score
	self.question[:ans_upvote_score]
end

def down_score
	self.question[:ans_downvote_score]
end

	def upvote
		self.answer_votes.create!(up_down_vote: up_score, user_id:current_user.id)
		Answer.where(id: self.id).first.increment!(:up_vote_count,1)
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
		self.answer_votes.create!(user_id:current_user.id, up_down_vote: down_score)
		Answer.where(id: self.id).first.increment!(:down_vote_count,1)
	end

end
