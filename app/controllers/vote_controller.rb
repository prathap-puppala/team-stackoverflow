class VoteController < ApplicationController
	def new
		@votes = Vote.new()
	end
end
