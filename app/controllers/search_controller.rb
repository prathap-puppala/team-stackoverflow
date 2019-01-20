# frozen_string_literal: true

# This class contains methods related to search
class SearchController < ApplicationController
  def new
    @key = params[:search][:key]
    if @key.length >= 1
      @results = Question.search(@key).paginate(page: params[:page],
                                                per_page: 10)
    else
      flash[:danger] = 'search term cannot be empty'
      redirect_to questions_path
    end
  end
end
