class CreateQuestions < ActiveRecord::Migration[5.2]
  def change
    create_table :questions do |t|
      t.bigint :user_id
      t.bigint :team_id
      t.string :subject
      t.text :description
      t.integer :ans_upvote_score, :limit => 2
      t.integer :ans_downvote_score, :limit => 2
      t.bigint :status_codes_id
      t.timestamps
    end
    add_foreign_key :questions, :users
    add_foreign_key :questions, :teams
  end
end
