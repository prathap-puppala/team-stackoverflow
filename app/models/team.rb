class Team < ApplicationRecord
	validates :team_name, presence: true, uniqueness: true

	has_many :users, :through => :team_admins
	has_many :team_admins
	has_many :user_teams
	has_many :users, :through => :user_teams
end
