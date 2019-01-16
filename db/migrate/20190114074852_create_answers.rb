class CreateAnswers < ActiveRecord::Migration[5.2]
  def change
    create_table :answers do |t|
      t.bigint :user_id
      t.bigint :question_id
      t.text :description
      t.integer :up_vote_count
      t.integer :down_vote_count
      t.boolean :status
      t.timestamps
    end
    add_foreign_key :answers, :users
    add_foreign_key :answers, :questions
  end
end
