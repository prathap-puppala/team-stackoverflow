class User < ApplicationRecord
	has_many :questions
	has_many :answers
	has_many :user_teams, dependent: :destroy
	has_many :team_admins
	has_many :teams, :through => :team_admins
	has_many :teams, :through => :user_teams
	acts_as_voter

	def self.find_or_create_from_auth_hash(auth)
		where(provider: auth.provider, uid: auth.uid).first_or_initialize.tap do |user|
			user.provider = auth.provider
			user.uid = auth.uid
			user.first_name = auth.info.first_name
			user.last_name = auth.info.last_name
			user.email = auth.info.email
			user.picture = auth.info.image
			user.save!
		end
	end	


	#def make_current
	#	Thread.current[:user] =self
	#end
end
