class UserTeam < ApplicationRecord
	belongs_to :user
	belongs_to :team
	belongs_to :team_admin, optional: true
end
