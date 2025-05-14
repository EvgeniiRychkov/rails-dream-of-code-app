require 'rails_helper'

RSpec.describe 'Courses', type: :request do
  describe 'GET /courses/:id' do
    before do
      trimester = Trimester.create!(
        term: 'Current term',
        year: Date.today.year.to_s,
        start_date: Date.today - 1.day,
        end_date: Date.today + 2.months,
        application_deadline: Date.today - 16.days
      )

      coding_class = CodingClass.create!(title: 'Ruby')
      @course = Course.create!(coding_class: coding_class, trimester: trimester)
      @student = Student.create!(
        first_name: 'Evgenii',
        last_name: 'Rychkov',
        email: 'evgeniirychkov@gmail.com'
      )
      Enrollment.create!(student: @student, course: @course)
    end

    it 'displays the course title and enrolled student name' do
      get "/courses/#{@course.id}"

      expect(response).to have_http_status(:ok)
      expect(response.body).to include(@course.coding_class.title)
      expect(response.body).to include(@student.first_name)
      expect(response.body).to include(@student.last_name)
    end
  end
end
