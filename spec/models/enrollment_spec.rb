require 'rails_helper'

RSpec.describe Enrollment, type: :model do
  describe '#is_past_application_deadline?' do
    let(:trimester) do
      Trimester.create(
        year: '2025',
        term: 'Winter',
        start_date: 1.week.from_now,
        end_date: 2.months.from_now,
        application_deadline: 1.week.ago
      )
    end
    let(:course) { Course.create!(trimester: trimester, coding_class: CodingClass.create!(title: 'Ruby')) }
    let(:student) { Student.create!(first_name: 'John', last_name: 'Doe', email: 'studenttwo@example.com') }

    context 'when enrollment was created before the application deadline' do
      it 'returns true' do
        enrollment = Enrollment.create!(
          course: course,
          student: student,
          created_at: 2.weeks.ago
        )

        expect(enrollment.is_past_application_deadline?).to be true
      end
    end

    context 'when enrollment was created after the application deadline' do
      it 'returns false' do
        enrollment = Enrollment.create!(
          course: course,
          student: student,
          created_at: Time.current
        )

        expect(enrollment.is_past_application_deadline?).to be false
      end
    end
  end
end
