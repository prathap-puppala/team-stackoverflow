# frozen_string_literal: true

# This class contains User related functions
class UserController < ApplicationController
  before_action :authenticate
  before_action :check_user_has_teams
  before_action :check_same_user

  def show
  end

  private
  def check_same_user
    if params[:id].to_i != current_user.id
      flash[:danger] = "You dont have privileges to perform this action"
      redirect_to questions_path
    end
  end
end
