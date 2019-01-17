class SessionsController < ApplicationController
	def new
	end
	def create
  	@user = User.find_or_create_from_auth_hash(request.env["omniauth.auth"])
  	session[:user_id] = @user.id
  	redirect_to questions_path
   end

   def cur

   end

   def destroy
  	session[:user_id] = nil
  	redirect_to root_path
  end
end