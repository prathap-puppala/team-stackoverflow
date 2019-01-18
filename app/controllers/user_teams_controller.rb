class UserTeamsController < ApplicationController
	def new
		@user_team = UserTeam.new
		@teams = Team.all
	end

	def create
		for i in params[:user_teams]
			@team_id=eval(i)
			current_user.user_teams.create!(team_id: @team_id[:value])
		end
        flash[:success] = "Teams preferences has been saved successfully"
        redirect_to questions_path
	end
end
