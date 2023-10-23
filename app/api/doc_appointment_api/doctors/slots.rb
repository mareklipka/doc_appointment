# frozen_string_literal: true

module DocAppointmentAPI
  class Doctors
    class Slots < Grape::API
      before do
        @doctor = Doctor.find(params[:doctor_id])
      end

      route_param :doctor_id do
        resource :slots do
          desc 'Return all free slots for a doctor'
          get :free do
            @doctor.slots.free
          end

          desc 'Return all slots for a doctor'
          get do
            present @doctor.slots.includes(:appointment)
          end

          route_param :id do
            desc 'Delete a slot'
            delete do
              @doctor.slots.free.find(params[:id]).destroy

              status :no_content
            end
          end
        end
      end
    end
  end
end
