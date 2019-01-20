# frozen_string_literal: true

# All common functions will present in this file.
class ApplicationController < ActionController::Base
  #protect_from_forgery with: :exception
  helper_method :current_user, :user_signed_in?, :authenticate

  # Returns current user object. Does not require any parameters.
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  # Checks whether user signed in or not. Does not require any parameters.
  def user_signed_in?
    !current_user.nil?
  end

  # Checks whether logged in user is same as current user_id.
  #  Required parameter is UserId.
  def same_user?(userid)
    userid == current_user.id
  end

  # Redirecting to Home page if user is not signed in.
  # Does not require any parameters.
  def authenticate
    redirect_to root_path unless user_signed_in?
  end

  # Checks and returns to Team Selection page if user doesn't have any.
  # Does not require any parameters.
  def check_user_has_teams
    flash[:danger] = 'Please choose teams to continue' if current_user.no_teams?
    redirect_to new_user_team_path if current_user.no_teams?
  end
end
