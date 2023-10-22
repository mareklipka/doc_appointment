# frozen_string_literal: true

FactoryBot.define do
  factory :doctor do
    name { FFaker::Name.name }
    start_hour { 8 }
    end_hour { 16 }
  end
end
