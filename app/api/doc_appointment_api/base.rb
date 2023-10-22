# frozen_string_literal: true

module DocAppointmentAPI
  class Base < Grape::API
    format :json

    rescue_from ActiveRecord::RecordNotFound do
      error!({ message: 'Not found' }, 404)
    end

    mount DocAppointmentAPI::Doctors
    mount DocAppointmentAPI::Appointments

    add_swagger_documentation
  end
end
