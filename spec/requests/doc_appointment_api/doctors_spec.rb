# frozen_string_literal: true

require 'rails_helper'

describe DocAppointmentAPI::Doctors do
  describe 'GET /api/v1/doctors' do
    subject(:request) do
      create_list(:doctor, 3)

      get '/api/v1/doctors'
    end

    it 'returns a successful response' do
      request
      expect(response).to have_http_status(:ok)
    end

    it 'returns a JSON response' do
      request
      expect(response.content_type).to eq('application/json')
    end
  end
end
