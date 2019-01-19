class QuestionAccess < ApplicationRecord
	belongs_to :question
	belongs_to :team, optional: true
	belongs_to :user_teams, optional: true
end
