# frozen_string_literal: true

# This class contains teams related functions
class TeamsController < ApplicationController
  before_action :authenticate

  def new
    @team = Team.new
  end

  def create
    @team = Team.new(params.require(:team).permit(:team_name))
    if @team.save
      current_user.team_admins.create!(team_id: @team.id)
      current_user.user_teams.create!(team_id: @team.id)
      flash[:success] = 'Teams has been saved successfully'
      redirect_to edit_user_team_path(current_user)
    else
      render 'new'
    end
  end

  def edit
    @team = Team.find(params[:id])
  end

  def update
    @team = Team.find(params[:id])
    if @team.update(params_require)
      redirect_to question_path(@question)
    else
      render 'edit'
    end
  end
end
