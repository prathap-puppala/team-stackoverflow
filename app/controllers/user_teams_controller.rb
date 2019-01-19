class UserTeamsController < ApplicationController
	def new
		@user_team = UserTeam.new
		@teams = Team.all
	end

	def create
		for i in params[:user_teams]
			current_user.user_teams.create!(team_id: i)
		end
        flash[:success] = "Teams preferences has been saved successfully"
        redirect_to questions_path
	end

	def edit
		@user_team = UserTeam.new
		@teams = Team.all
	end	

	def update
		@user_team_access = current_user.user_teams
		@user_team_access.destroy_all
		for i in params[:user_teams]
			current_user.user_teams.create!(team_id: i)
		end
        flash[:success] = "Teams preferences has been saved successfully"
        redirect_to edit_user_team_path(current_user)
	end

end
