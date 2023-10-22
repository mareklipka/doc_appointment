# frozen_string_literal: true

require 'rails_helper'

describe DocAppointmentAPI::Doctors do
  describe 'GET /api/doctors' do
    subject(:request) do
      get '/api/doctors'
    end

    before do
      create_list(:doctor, 3)
    end

    it 'returns a successful response' do
      request
      expect(response).to have_http_status(:ok)
    end

    it 'returns a JSON response' do
      request
      expect(response.content_type).to eq('application/json')
    end

    it 'returns the actual doctors data' do
      request
      expect(response.body).to include(*Doctor.pluck(:name))
    end
  end
end
