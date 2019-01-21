# frozen_string_literal: true

# site_settings data
SiteSetting.create(key: 'question_up_score',value: 10)
SiteSetting.create(key: 'question_down_score', value: -5)
SiteSetting.create(key: 'answer_up_score', value: 10)
SiteSetting.create(key: 'answer_down_score', value: -5)

# status_codes data
StatusCode.create(name: 'opened')
StatusCode.create(name: 'accepted')
StatusCode.create(name: 'closed')
StatusCode.create(name: 'deleted')

# teams data
SAMPLE_TEAMS = [
  'Fresh Reports', 'Fresh Search', 'Fresh Desk', 'Fresh support'
].freeze

SAMPLE_TEAMS.each do |team|
  Team.create(team_name: team)
end

# tags data
TAGS = [
  'rails', 'ruby', 'ruby on rails', 'python', 'flask', 'C', 'CPP', 'Java',
  'Machine Learning', 'General Questions'
].freeze

TAGS.each do |tag|
  Tag.create(name: tag)
end

# questions data
SAMPLE_QUESTIONS = [
  'How was your experience with Tinder in India?',
  'What development tools have you used?',
  'What languages have you programmed in?',
  'How did you manage source control?',
  'Describe your production deployment process.',
  'How much reuse do you get out of the code that you develop, and how?',
  'Which do you prefer; service-oriented or batch-oriented solutions?',
  'Compare and contrast REST and SOAP web services.',
  'What is a SAN, and how is it used?',
  'What is clustering, and describe its use?',
  'What is the role of the DMZ in network architecture?',
  'Describe the difference between optimistic and pessimistic locking.',
  'What are transaction logs, and how are they used?'
].freeze

SAMPLE_QUESTIONS.each_with_index do |question, index|
  # questions data
  Question.create(user_id: 1,
                  subject: question,
                  description: question,
                  up_vote_count: 0,
                  down_vote_count: 0,
                  team_id: (index % 4) + 1)

  # question tags data
  QuestionTag.create(question_id: (index + 1), tag_id: 10)

  # question access data
  SAMPLE_TEAMS.each_with_index do |_team, team_index|
    QuestionAccess.create(question_id: (index + 1),
                          team_id: (team_index + 1),
                          answer_access: 1,
                          vote_access: 1)
  end
end
