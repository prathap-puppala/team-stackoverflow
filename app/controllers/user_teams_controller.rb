class UserTeamsController < ApplicationController
	def new
		@user_team = UserTeam.new
		@teams = Team.all
	end

	def create
		for i in params[:user_teams_input]
			i
			@user_team = UserTeam.new(params_permit(i))
			if @user_team.save

			end
		end

	end

	private
	def params_permit(i)
		params.require(:user_team).permit(:team_id)
	end
end
