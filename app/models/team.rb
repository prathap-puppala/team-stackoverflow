class Team < ApplicationRecord
	has_many :team_admins, :through => :user
	has_many :user_teams
	has_many :users, :through => :user_teams
end
