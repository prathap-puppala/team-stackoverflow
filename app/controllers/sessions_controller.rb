class SessionsController < ApplicationController
	def new
    if user_signed_in?
      redirect_to questions_path
    end
	end
	def create
  	@user = User.find_or_create_from_auth_hash(request.env["omniauth.auth"])
  	session[:user_id] = @user.id
    if @user.user_teams.count<=0
      redirect_to new_user_team_path
    else 
      	redirect_to questions_path
    end
   end


   def destroy
  	session[:user_id] = nil
  	redirect_to root_path
  end
end