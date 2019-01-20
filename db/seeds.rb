# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

SiteSetting.create(key: 'question_up_score', value: 10)
SiteSetting.create(key: 'question_down_score', value: -5)
StatusCode.create(name: 'opened')
StatusCode.create(name: 'accepted')
StatusCode.create(name: 'closed')
StatusCode.create(name: 'deleted')

Sample_Teams = [
	"Fresh Reports",
	"Fresh Search",
	"Fresh Desk",
	"Fresh support"
]

Sample_Teams.each do |team|
	Team.create(team_name: team)
end


Tags = [
	"rails",
	"ruby",
	"ruby on rails",
	"python",
	"flask",
	"C",
	"CPP",
	"Java",
	"Machine Learning",
	"General Questions"
]
Tags.each do |tag|
	Tag.create(name:tag)
end

Sample_Questions =[
"How was your experience with Tinder in India?",
	"What development tools have you used?",
	"What languages have you programmed in?",
	"How did you manage source control?",
	"Describe your production deployment process.",
	"How much reuse do you get out of the code that you develop, and how?",
	"Which do you prefer; service-oriented or batch-oriented solutions?",
	"Compare and contrast REST and SOAP web services.",
	"What is a SAN, and how is it used?",
	"What is clustering, and describe its use?",
	"What is the role of the DMZ in network architecture?",
	"Describe the difference between optimistic and pessimistic locking.",
	"What are transaction logs, and how are they used?"
]

answer_up_down_vote_score = [10,5]

Sample_Questions.each_with_index do |question,index|



	Question.create(user_id:1,subject:question,
									description:question,
									ans_upvote_score:answer_up_down_vote_score[0],
									ans_downvote_score:answer_up_down_vote_score[1],
									up_vote_count:0,
									down_vote_count:0,
									team_id:(index%4)+1)

	QuestionTag.create(question_id:(index+1),tag_id:10)

	Sample_Teams.each_with_index do |team,team_index|
					QuestionAccess.create(question_id:(index+1),
																team_id:(team_index+1),
																answer_access:1,
																vote_access:1)
					end


end




# Dir[File.join(Rails.root, 'db', 'seeds', '*.rb')].sort.each do |seed|
#   load seed
# end
