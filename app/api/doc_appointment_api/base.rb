# frozen_string_literal: true

module DocAppointmentAPI
  class Base < Grape::API
    format :json

    mount ::DocAppointmentAPI::Doctors
  end
end
