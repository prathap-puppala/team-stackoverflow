class CreateAnswerVotes < ActiveRecord::Migration[5.2]
  def change
    create_table :answer_votes do |t|
      t.bigint :user_id
      t.bigint :answer_id
      t.integer :up_down_vote, :limit => 2

      t.timestamps
    end
    add_foreign_key :answer_votes, :users
    add_foreign_key :answer_votes, :answers
  end
end
