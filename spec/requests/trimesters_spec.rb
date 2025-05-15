require 'rails_helper'

RSpec.describe 'Trimesters', type: :request do
  describe 'GET /trimesters' do
    context 'trimesters exist' do
      before do
        (1..2).each do |i|
          Trimester.create!(
            term: "Term #{i}",
            year: '2025',
            start_date: '2025-01-01',
            end_date: '2025-01-01',
            application_deadline: '2025-01-01'
          )
        end
      end

      it 'returns a page containing names of all trimesters' do
        get '/trimesters'
        expect(response.body).to include('Term 1 2025')
        expect(response.body).to include('Term 2 2025')
      end
    end

    context 'trimesters do not exist' do
      it 'returns a page with empty list of Trimesters' do
        get '/trimesters'
        expect(response.body).not_to include('<li>')
      end
    end
  end

  describe 'PUT /trimesters/:id' do
    let!(:trimester) do
      Trimester.create!(
        term: 'Fall',
        year: '2025',
        start_date: '2025-09-01',
        end_date: '2025-12-15',
        application_deadline: Date.today + 30
      )
    end

    context 'with a valid application deadline and existing trimester' do
      let(:valid_date) { (Date.today + 60).to_s }

      it "updates the trimester's application deadline" do
        put "/trimesters/#{trimester.id}", params: { trimester: { application_deadline: valid_date } }

        expect(response).to have_http_status(:found)
        expect(trimester.reload.application_deadline.to_s).to eq(valid_date)
      end
    end

    context 'without an application deadline' do
      it 'returns a 400 bad request status' do
        put "/trimesters/#{trimester.id}", params: {}

        expect(response).to have_http_status(:bad_request)
      end
    end

    context 'with an invalid application deadline' do
      it 'returns a 400 bad request status' do
        put "/trimesters/#{trimester.id}", params: { application_deadline: 'not-a-date' }

        expect(response).to have_http_status(:bad_request)
      end
    end

    context 'with a non-existent trimester id' do
      it 'returns a 404 not found status' do
        put '/trimesters/999999', params: { application_deadline: Date.today.to_s }

        expect(response).to have_http_status(:not_found)
      end
    end
  end
end
