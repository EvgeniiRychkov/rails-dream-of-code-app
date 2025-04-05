class Topic < ApplicationRecord
  has_many :lessons_topics
  has_many :lessons, through: :lessons_topics
end
