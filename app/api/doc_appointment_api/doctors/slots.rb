# frozen_string_literal: true

module DocAppointmentAPI
  class Doctors
    class Slots < Grape::API
      route_param :doctor_id do
        resource :slots do
          desc 'Return all free slots for a doctor'
          get :free do
            doctor = Doctor.find(params[:doctor_id])
            doctor.slots.free
          end
        end
      end
    end
  end
end
