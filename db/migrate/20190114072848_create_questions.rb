class CreateQuestions < ActiveRecord::Migration[5.2]
  def change
    create_table :questions do |t|
      t.bigint :user_id
      t.bigint :team_id
      t.string :subject
      t.text :description
      t.integer :ans_upvote_score, :limit => 2
      t.integer :ans_downvote_score, :limit => 2
      t.integer :up_vote_count, default: 0
      t.integer :down_vote_count, default: 0
      t.bigint :status_code_id, default: 1
      t.timestamps
    end
    add_foreign_key :questions, :users
    add_foreign_key :questions, :teams
    add_foreign_key :questions, :status_codes
  end
end
