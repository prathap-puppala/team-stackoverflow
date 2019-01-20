# frozen_string_literal: true

# This class contains session related functions
class TagsController < ApplicationController
  before_action :authenticate
  before_action :check_user_has_teams

  def new
    nil
  end
end
