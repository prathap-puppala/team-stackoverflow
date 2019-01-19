class UserTeam < ApplicationRecord
	belongs_to :user
	belongs_to :team
	has_many :questions
	belongs_to :team_admin, optional: true
	attr_accessor :current_user

	def filled?
		current_user.user_teams.empty?
	end

end
