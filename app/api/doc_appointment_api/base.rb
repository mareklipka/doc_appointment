# frozen_string_literal: true

module DocAppointmentAPI
  class Base < Grape::API
    format :json

    mount DocAppointmentAPI::Doctors
    mount DocAppointmentAPI::Appointments

    add_swagger_documentation
  end
end
