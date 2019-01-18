class QuestionAccess < ApplicationRecord
	belongs_to :question
	belongs_to :team
end
