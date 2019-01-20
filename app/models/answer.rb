# frozen_string_literal: true

# contains answer related functions
class Answer < ApplicationRecord
  validates :description, presence: true

  belongs_to :user
  belongs_to :question
  has_many :answer_votes

  def self.get_displayable(qsn_id)
    Answer.where(question_id: qsn_id)
  end

  def user_not_voted?(user)
    answer_votes.where(user_id: user.id).empty?
  end

  def upvote(user)
    up_vote_score = Question.find(question_id)[:ans_upvote_score]
    answer_votes.create!(user_id: user.id,
                         up_down_vote: up_vote_score)
    increment!(:up_vote_count, 1)
  end

  def downvote(user)
    down_vote_score = Question.find(question_id)[:ans_downvote_score]
    answer_votes.create!(user_id: user.id,
                         up_down_vote: down_vote_score)
    increment!(:down_vote_count, 1)
  end

  def accept
    update(status: true)
    Question.find(question_id).update(status_code_id: 2)
  end
end
