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

  def user_upvoted?(user)
    answer_votes.where('user_id=? AND up_down_vote>0', "%#{user.id}%")
    # answer_votes.where(user_id: user.id, up_down_vote: upvote_score).empty?
  end

  def user_downvoted?(user)
    answer_votes.where('user_id=? AND up_down_vote<=0', "%#{user.id}%")
    # answer_votes.where(user_id: user.id, up_down_vote: down_vote_score).empty?
  end

  def upvote_score
    Question.find(question_id)[:ans_upvote_score]
  end

  def downvote_score
    Question.find(question_id)[:ans_downvote_score]
  end

  def upvote(user)
    if user_not_voted?(user)
      answer_votes.create!(user_id: user.id,
                           up_down_vote: upvote_score)
      increment!(:up_vote_count, 1)
    elsif user_downvoted?(user)
      decrement!(:down_vote_count)
      increment!(:up_vote_count)
      answer_votes.first.update(up_down_vote: downvote_score)
    end
  end

  def downvote(user)
    if user_not_voted?(user)
      answer_votes.create!(user_id: user.id,
                           up_down_vote: downvote_score)
      increment!(:down_vote_count, 1)
    elsif user_upvoted?(user)
      decrement!(:up_vote_count)
      increment!(:down_vote_count)
      answer_votes.first.update(up_down_vote: downvote_score)
    end
  end

  def accept
    update(status: true)
    Question.find(question_id).update(status_code_id: 2)
  end
end
