# frozen_string_literal: true

FactoryBot.define do
  factory :slot do
    doctor
    starts_at { Time.zone.now.change(min: 0, sec: 0) }

    trait :with_appointment do
      appointment
    end
  end
end
