# frozen_string_literal: true

FactoryBot.define do
  factory :appointment do
    appointee_name { FFaker::Name.name }
    appointee_phone { FFaker::PhoneNumber.phone_number }
    slot
  end
end
