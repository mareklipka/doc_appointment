# frozen_string_literal: true

module DocAppointmentAPI
  class Doctors < Grape::API
    resource :doctors do
      desc 'Return all doctors'
      get do
        Doctor.all
      end

      mount Slots
    end
  end
end
