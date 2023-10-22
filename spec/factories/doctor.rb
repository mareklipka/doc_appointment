# frozen_string_literal: true

FactoryBot.define do
  factory :doctor do
    name { FFaker::Name.name }
    start_hour { 8 }
    end_hour { 16 }

    trait :with_slots do
      after(:create) do |doctor|
        SlotCreator.call(doctor, Time.zone.now, 1.week.from_now)
      end
    end
  end
end
