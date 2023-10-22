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

      desc 'Return all appointments'

      get do
        present Appointment.all
      end

      route_param :id do
        desc 'Update an appointment'

        params do
          optional :slot_id, type: Integer
          optional :patient_name, type: String
          optional :patient_phone, type: String
        end

        patch do
          appointment = Appointment.find(params[:id])

          if appointment.update(declared(params, include_missing: false))
            present appointment
          else
            status :unprocessable_entity
            { errors: appointment.errors }
          end
        end

        desc 'Delete an appointment'

        delete do
          Appointment.find(params[:id]).destroy

          status :no_content
        end
      end
    end
  end
end
