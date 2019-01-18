class TeamsController < ApplicationController
	def new
		@team = Team.new
	end

	def create
		@team = Team.new(params.require(:team).permit(:team_name))
		if @team.save
			current_user.team_admins.create!(team_id: @team.id)
			 flash[:success] = "Teams has been saved successfully"
        	redirect_to questions_path
        else
        	render 'new'
		end
	end
end
