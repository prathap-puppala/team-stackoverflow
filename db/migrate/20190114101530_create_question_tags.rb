class CreateQuestionTags < ActiveRecord::Migration[5.2]
  def change
    create_table :question_tags do |t|
      t.bigint :question_id
      t.bigint :tag_id

      t.timestamps
    end

    add_foreign_key :question_tags, :questions
    add_foreign_key :question_tags, :tags
  end
end
