# frozen_string_literal: true

require 'rails_helper'

describe DocAppointmentAPI::Doctors::Slots do
  describe 'GET /api/v1/doctors/:doctor_id/slots/free' do
    subject(:request) do
      get "/api/doctors/#{doctor.id}/slots/free"
    end

    let(:doctor) { create(:doctor, :with_slots) }

    it 'returns a successful response' do
      request
      expect(response).to have_http_status(:ok)
    end

    it 'returns a JSON response' do
      request
      expect(response.content_type).to eq('application/json')
    end

    it 'returns the actual slots data' do
      request
      expect(response.body).to include(*doctor.slots.pluck(:starts_at).map(&:to_json))
    end

    it 'returns only free slots' do
      slot = doctor.slots.first
      create(:appointment, slot:)

      request

      expect(response.body).not_to include(slot.starts_at.to_json)
    end
  end
end
