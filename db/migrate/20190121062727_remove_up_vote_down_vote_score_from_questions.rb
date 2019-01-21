# frozen_string_literal: true

class RemoveUpVoteDownVoteScoreFromQuestions < ActiveRecord::Migration[5.2]
  def change
    remove_column :questions, :ans_upvote_score
    remove_column :questions, :ans_downvote_score
  end
end
