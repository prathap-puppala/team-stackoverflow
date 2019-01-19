class UserController < ApplicationController
	before_action :authenticate
	before_action :check_user_filled_teams
	before_action :same_user

  def show
  	@user = User.find(params[:id])
  end

	private
	def same_user
		if params[:id].to_i != current_user.id
			flash[:danger] = "You dont have privileges to perform this action"
			redirect_to questions_path
		end
	end
end
