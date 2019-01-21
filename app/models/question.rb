# frozen_string_literal: true

# contains question related functions
class Question < ApplicationRecord
  validates :subject, presence: true
  validates :description, presence: true

  has_many :answers, dependent: :destroy
  belongs_to :user
  has_many :question_tags, dependent: :destroy
  has_many :tags, through: :question_tags
  has_many :question_accesses
  has_many :question_votes

  UP_DOWN_SCORE = [
    SiteSetting.getvalue('question_up_score'),
    SiteSetting.getvalue('question_down_score')
  ].freeze

  # Following function returns displayable Questions
  def self.get_displayable(user, question_id = nil)
    user_teams_list = user.team_ids
    ques = question_id.present? ? Question.where(id: question_id) : Question.all
    ques.select do |question|
      @team_ids = question.question_accesses.pluck(:team_id)
      (!(@team_ids & user_teams_list).empty? &&
        question[:status_code_id].to_i != 4)
    end
  end

  def can_be_displayed?(user)
    !(question_accesses.pluck(:team_id) & user.team_ids).empty? &&
      status_code_id.to_i != 4
  end

  def can_be_answered?(user)
    @team_ids = question_accesses.select do |access|
      access[:answer_access] == true
    end.pluck(:team_id)
    !(@team_ids & user.team_ids).empty? &&
      status_code_id.to_i != 4
  end

  def can_be_voted?(user)
    @team_ids = question_accesses.select do |access|
      access[:vote_access] == true
    end.pluck(:team_id)
    !(@team_ids & user.team_ids).empty? &&
      status_code_id.to_i != 4
  end

  def self.search(key)
    Question.where('subject LIKE ?', "%#{key}%")
  end

  def user_not_voted?(user)
    question_votes.where(user_id: user.id).empty?
  end

  def user_upvoted?(user)
    question_votes.where('user_id=? AND up_down_vote>0', "#{user.id}").any?
  end

  def user_downvoted?(user)
    question_votes.where("user_id=? AND up_down_vote<=0", "#{user.id}").any?
  end

  def upvote(user)
    if user_not_voted?(user)
      question_votes.create!(user_id: user.id,
                             up_down_vote: UP_DOWN_SCORE[0])
      increment!(:up_vote_count, 1)
    elsif user_downvoted?(user)
      decrement!(:down_vote_count)
      increment!(:up_vote_count)
      question_votes.first.update(up_down_vote: UP_DOWN_SCORE[0])
    end
  end

  def downvote(user)
    if user_not_voted?(user)
      question_votes.create!(user_id: user.id,
                             up_down_vote: UP_DOWN_SCORE[1])
      increment!(:down_vote_count, 1)
    elsif user_upvoted?(user)
      decrement!(:up_vote_count)
      increment!(:down_vote_count)
      question_votes.first.update(up_down_vote: UP_DOWN_SCORE[1])
    end
  end

  def tags
    @tags = ''
    question_tags.each do |question_tag|
      @tags += '"' + question_tag.tag.name + '",'
    end
    @tags = @tags[0...-1]
  end

  def destroy_tags
    QuestionTag.where(question_id: id).destroy_all
  end

  def destroy_question_accesses
    QuestionAccess.where(question_id: id).destroy_all
  end

  def close
    update(status_code_id: 3)
  end

  def destroy
    update(status_code_id: 4)
  end

  def process_question_accesses(params)
    if params.key?(:view_access)
      params[:view_access].each do |i|
        question_accesses.create!(team_id: i)
      end
    else
      flash[:danger] = 'View Level is minimum'
      return false
    end

    if params.key?(:answer_access)
      params[:answer_access].each do |i|
        QuestionAccess.where(question_id: id,
                             team_id: i).update_all(answer_access: true)
      end
    end

    return unless params.key?(:vote_access)

    params[:vote_access].each do |i|
      QuestionAccess.where(question_id: id,
                           team_id: i). update_all(vote_access: true)
    end
    true
  end

  def process_tags(params)
    tags = params['hidden-tags'].split(',')
    return false if tags.empty?

    tag = nil
    tags.each do |i|
      tag = Tag.find_by(name: i)
      tag ||= Tag.create(name: i)
      question_tags.create!(tag_id: tag.id)
    end
    true
  end
end
