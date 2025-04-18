require 'rails_helper'

RSpec.describe 'Mentors', type: :request do
  describe 'GET /mentors' do
    context 'mentors exist' do
      before do
        (1..2).each do |i|
          Mentor.create!(
            first_name: "Mentor #{i}",
            last_name: "Last #{i}",
            email: "#{i}@gmail.com",
            max_concurrent_students: 5
          )
        end
      end

      it 'returns a page containing names of all mentors' do
        get '/mentors'
        expect(response.body).to include('Mentor 1')
        expect(response.body).to include('Mentor 2')
        expect(response.body).to include('First name:')
      end
    end

    context 'mentors do not exist' do
      it 'returns a page without any mentor list items' do
        get '/mentors'
        expect(response.body).not_to include('First name:')
      end
    end
  end

  describe 'GET /mentors/:id' do
    context 'mentor exists' do
      let(:mentor) do
        Mentor.create!(
          first_name: 'Test',
          last_name: 'Mentor',
          email: 'test@test.com',
          max_concurrent_students: 5
        )
      end

      it 'returns a page with mentor details' do
        get "/mentors/#{mentor.id}"
        expect(response).to have_http_status(:ok)
        expect(response.body).to include('Test')
        expect(response.body).to include('Mentor')
        expect(response.body).to include('test@test.com')
        expect(response.body).to include('Max concurrent students:')
      end
    end

    context 'mentor does not exist' do
      it 'returns 404 not found' do
        get '/mentors/999999'
        expect(response).to have_http_status(:not_found)
      end
    end
  end
end
