class SearchController < ApplicationController
  def new
    @key = params[:search][:key]
    @results = Question.search(@key).paginate(page: params[:page], per_page: 10)
  end
end
