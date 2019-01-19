class Question < ApplicationRecord
	has_many :answers, dependent: :destroy
	belongs_to :user
	has_many :question_tags, dependent: :destroy
	has_many :tags, :through => :question_tags
	has_many :question_accesses
	#has_many :votes, :as => :votable
	has_many :question_votes
	#acts_as_votable
end
