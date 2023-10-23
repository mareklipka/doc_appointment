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

  describe 'GET /api/v1/appointments' do
    subject(:request) do
      get '/api/appointments'
    end

    before do
      create_list(:appointment, 3)
    end

    it 'returns a successful response' do
      request

      expect(response).to have_http_status(:ok)
    end

    it 'returns a JSON response' do
      request

      expect(response.content_type).to eq('application/json')
    end

    it 'returns the actual appointments data' do
      request

      expect(response.body).to include(*Appointment.pluck(:patient_name))
    end

    it 'returns hours of the appointments' do
      request

      expect(response.body).to include(*Slot.joins(:appointment).pluck(:starts_at).map(&:to_json))
    end

    it 'returns the doctor name' do
      request

      expect(response.body).to include(*Doctor.joins(slots: :appointment).pluck(:name))
    end
  end

  describe 'PATCH /api/v1/appointments/:id' do
    subject(:request) do
      patch "/api/appointments/#{appointment.id}", params:
    end

    let(:appointment) { create(:appointment) }

    context 'when the params are valid' do
      let(:params) do
        {
          patient_name: FFaker::Name.name,
          patient_phone: FFaker::PhoneNumber.phone_number
        }
      end

      it 'returns a successful' do
        request

        expect(response).to have_http_status(:ok)
      end

      it 'updates the appointment' do
        expect { request }.to change { appointment.reload.patient_name }.to(params[:patient_name])
      end
    end

    context 'when the params are invalid' do
      let(:params) do
        {
          patient_name: ''
        }
      end

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

  describe 'DELETE /api/v1/appointments/:id' do
    subject(:request) do
      delete "/api/appointments/#{appointment.id}"
    end

    let(:appointment) { create(:appointment) }

    it 'returns a no content response' do
      request

      expect(response).to have_http_status(:no_content)
    end

    it 'deletes the appointment' do
      appointment
      expect { request }.to change(Appointment, :count).by(-1)
    end

    context 'when the id is invalid' do
      it 'returns a not found response' do
        appointment.destroy

        request

        expect(response).to have_http_status(:not_found)
      end
    end
  end
end
