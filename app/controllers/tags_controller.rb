class TagsController < ApplicationController
	before_action :authenticate
	before_action :check_user_filled_teams
	
  def new
  end
end
