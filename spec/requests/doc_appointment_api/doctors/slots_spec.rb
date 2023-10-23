# frozen_string_literal: true

require 'rails_helper'

describe DocAppointmentAPI::Doctors::Slots do
  let(:doctor) { create(:doctor, :with_slots) }

  describe 'GET /api/v1/doctors/:doctor_id/slots/free' do
    subject(:request) do
      get "/api/doctors/#{doctor.id}/slots/free"
    end

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

  describe 'GET /api/v1/doctors/:doctor_id/slots' do
    subject(:request) do
      get "/api/doctors/#{doctor.id}/slots"
    end

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

    it 'returns all slots' do
      request

      expect(response.parsed_body.size).to eq(doctor.slots.size)
    end
  end

  describe 'DELETE /api/v1/doctors/:doctor_id/slots/:id' do
    subject(:request) do
      delete "/api/doctors/#{doctor.id}/slots/#{slot.id}"
    end

    let(:slot) { doctor.slots.first }

    it 'returns a no content response' do
      request

      expect(response).to have_http_status(:no_content)
    end

    it 'deletes the slot' do
      doctor # create doctor and slots

      expect { request }.to change(Slot, :count).by(-1)
    end

    context 'when the slot has an appointment' do
      before do
        create(:appointment, slot:)
      end

      it 'returns 404' do
        request

        expect(response).to have_http_status(:not_found)
      end

      it 'does not delete the slot' do
        expect { request }.not_to change(Slot, :count)
      end
    end
  end
end
