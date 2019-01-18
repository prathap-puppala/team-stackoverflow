class CreateQuestionAccesses < ActiveRecord::Migration[5.2]
  def change
    create_table :question_accesses do |t|
      t.bigint :question_id
      t.bigint :team_id
      t.boolean :answer_access, default: false
      t.boolean :vote_access, default: false

      t.timestamps
    end
    add_foreign_key :question_accesses, :questions
    add_foreign_key :question_accesses, :teams
    
  end
end
