# frozen_string_literal: true

# This class contains session related functions
class SessionsController < ApplicationController
  def new
    redirect_to questions_path if user_signed_in?
  end

  # User Login function. Does not require any parameters.
  def create
    @user = User.find_or_create_from_auth_hash(request.env['omniauth.auth'])
    session[:user_id] = @user.id
    redirect_to questions_path
  end

  # User Logout function. Does not require any parameters.
  def destroy
    reset_session
    redirect_to root_path
  end
end
