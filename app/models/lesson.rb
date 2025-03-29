class Lesson < ApplicationRecord
  belongs_to :course
  has_many :lessons_topics
  has_many :topics, through: :lessons_topics
end
