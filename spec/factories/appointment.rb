# frozen_string_literal: true

FactoryBot.define do
  factory :appointment do
    patient_name { FFaker::Name.name }
    patient_phone { FFaker::PhoneNumber.phone_number }
    slot
  end
end
