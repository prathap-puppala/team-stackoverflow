# frozen_string_literal: true

# This class contains user teams related functions
class UserTeamsController < ApplicationController
  before_action :authenticate
  before_action :check_same_user, only: %i[edit update]

  def new
    redirect_to edit_user_team_path(current_user) if current_user.no_teams?
    @teams = Team.all
  end

  def create
    params[:user_teams].each do |i|
      current_user.user_teams.create!(team_id: i)
    end
    flash[:success] = 'Teams preferences has been saved successfully'
    redirect_to questions_path
  end

  def edit
    @user_team = UserTeam.new
    @teams = Team.all
  end

  def update
    @user_team_access = current_user.user_teams
    @user_team_access.destroy_all
    params[:user_teams].each do |i|
      current_user.user_teams.create!(team_id: i)
    end
    flash[:success] = 'Teams preferences has been saved successfully'
    redirect_to root_path
  end

  private

  def check_same_user
    return if same_user?(params[:id].to_i)

    flash[:danger] = 'You dont have privileges to perform this action'
    redirect_to user_path(current_user)
  end
end
