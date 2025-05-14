require 'rails_helper'

RSpec.describe 'Dashboard', type: :request do
  describe 'GET /dashboard' do
    before do
      current_trimester = Trimester.create!(
        term: 'Current term',
        year: Date.today.year.to_s,
        start_date: Date.today - 1.day,
        end_date: Date.today + 2.months,
        application_deadline: Date.today - 16.days
      )

      start_date = Date.today + 4.months
      past_trimester = Trimester.create!(
        term: 'Future term',
        year: start_date.year.to_s,
        start_date: start_date,
        end_date: start_date + 2.month,
        application_deadline: start_date - 1.months
      )

      ruby_class = CodingClass.create!(title: 'Ruby')
      react_class = CodingClass.create!(title: 'React')

      Course.create!(coding_class: ruby_class, trimester: current_trimester)
      Course.create!(coding_class: react_class, trimester: past_trimester)
    end

    it 'returns a 200 OK status' do
      get '/dashboard'
      expect(response).to have_http_status(:ok)
    end

    it 'displays the current trimester' do
      get '/dashboard'
      expect(response.body).to include("Current term - #{Date.today.year} Courses")
    end

    it 'displays links to the courses in the current trimester' do
      get '/dashboard'
      expect(response.body).to include('<li>')
      expect(response.body).to include('Ruby')
    end

    it 'displays the upcoming trimester' do
      get '/dashboard'
      expect(response.body).to include("Future term - #{(Date.today + 4.months).year} Courses")
    end

    it 'displays links to the courses in the upcoming trimester' do
      get '/dashboard'
      expect(response.body).to include('<li>')
      expect(response.body).to include('React')
    end
  end
end
