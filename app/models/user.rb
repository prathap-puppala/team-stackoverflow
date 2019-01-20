# frozen_string_literal: true

# This class contains User related functions
class User < ApplicationRecord
  has_many :questions
  has_many :answers
  has_many :user_teams, dependent: :destroy
  has_many :team_admins
  has_many :teams, through: :team_admins
  has_many :teams, through: :user_teams

  def self.find_or_create_from_auth_hash(auth)
    where(provider: auth.provider, uid: auth.uid)
      .first_or_initialize.tap do |user|
      user.attributes = {
        provider: auth.provider,
        uid: auth.uid,
        first_name: auth.info.first_name,
        last_name: auth.info.last_name,
        email: auth.info.email,
        picture: auth.info.image
      }
      user.save!
    end
  end

  def self.teams_list(user)
    user.user_teams.collect(&:team_id)
  end

  # Returns User team ids
  def teams_ids
    user_teams.collect(&:team_id)
  end

  # Returns User team names
  def teams_names
    user_teams.map { |user_team| user_team.team[:team_name] }
  end

  # Returns team names for which user is admin
  def teams_acting_as_admin
    team_admins.map { |team_admin| team_admin.team[:team_name] }
  end

  # Checks whether User has teams or not
  def no_teams?
    user_teams.empty?
  end

  # User full name
  def name
    first_name + ' ' + last_name
  end
end
