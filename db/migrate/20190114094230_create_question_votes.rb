class CreateQuestionVotes < ActiveRecord::Migration[5.2]
  def change
    create_table :question_votes do |t|
      t.bigint :user_id
      t.bigint :question_id
      t.integer :up_down_vote, :limit=> 2

      t.timestamps
    end
    add_foreign_key :question_votes, :users
    add_foreign_key :question_votes, :questions
  end
end
