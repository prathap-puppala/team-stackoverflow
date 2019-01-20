class UserTeamsController < ApplicationController
	before_action :authenticate
	before_action :same_user, only: [:edit, :update]

	def new
		@user_team = UserTeam.new
	  @user_team.current_user = current_user
	  redirect_to edit_user_team_path(current_user) if !@user_team.filled?
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
        redirect_to root_path
	end

	private
	def same_user
		if params[:id].to_i != current_user.id
			flash[:danger] = "You dont have privileges to perform this action"
			redirect_to user_path(current_user)
		end
	end

end
