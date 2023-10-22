# frozen_string_literal: true

require 'rails_helper'

describe DocAppointmentAPI::Appointments do
  describe 'POST /api/v1/appointments' do
    subject(:request) do
      post '/api/appointments', params:
    end

    let(:params) do
      {
        slot_id: slot.id,
        patient_name: FFaker::Name.name,
        patient_phone: FFaker::PhoneNumber.phone_number
      }
    end

    context 'when the params are valid' do
      let(:slot) { create(:slot) }

      it 'returns a created response' do
        request

        expect(response).to have_http_status(:created)
      end

      it 'creates a new appointment' do
        expect { request }.to change(Appointment, :count).by(1)
      end
    end

    context 'when the params are invalid' do
      let(:slot) { create(:slot, :with_appointment) }

      it 'returns an unprocessable entity response' do
        request

        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'returns an error message' do
        request

        expect(response.body).to include('errors')
      end
    end
  end
end
