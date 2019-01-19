class Answer < ApplicationRecord
	belongs_to :user
	belongs_to :question
	#has_many :votes, :as => :votable
	has_many :answer_votes
	#acts_as_votable
end