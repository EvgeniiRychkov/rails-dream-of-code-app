class Course < ApplicationRecord
  belongs_to :coding_class
  belongs_to :trimester
  has_many :enrollments

  delegate :title, to: :coding_class

  def student_name_list
    enrollments.includes(:student).map do |enrollment|
      enrollment.student.full_name
    end
  end

  def student_email_list
    enrollments.includes(:student).map do |enrollment|
      enrollment.student.email
    end
  end
end
