class QuestionTag < ApplicationRecord
	belongs_to :tag
	belongs_to :question
	# belongs_to :question
end
