# frozen_string_literal: true

module DocAppointmentAPI
  class Appointments < Grape::API
    resource :appointments do
      desc 'Create an appointment'

      params do
        requires :slot_id, type: Integer
        requires :patient_name, type: String
        requires :patient_phone, type: String
      end

      post do
        appointment = Appointment.new(declared(params))

        if appointment.save
          status :created
          appointment
        else
          status :unprocessable_entity
          { errors: appointment.errors }
        end
      end
    end
  end
end
