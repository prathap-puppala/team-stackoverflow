class QuestionAccess < ApplicationRecord
	belongs_to :question
	belongs_to :team, optional: true
end
