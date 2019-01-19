class ApplicationController < ActionController::Base
  #protect_from_forgery with: :exception
  helper_method :current_user
  helper_method :user_signed_in?
  helper_method :authenticate

  def authenticate
  	redirect_to root_path unless user_signed_in?
  end

  def current_user
  	@current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def user_signed_in?
  	!!current_user
  end

  def check_user_filled_teams
    userteam = UserTeam.new
    userteam.current_user = current_user
    flash[:danger] = "Please choose teams to continue" if !!userteam.filled?
    redirect_to new_user_team_path if !!userteam.filled?
  end
end
