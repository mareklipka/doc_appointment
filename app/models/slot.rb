# frozen_string_literal: true

class Slot < ApplicationRecord
  DURATION = 30.minutes

  belongs_to :doctor
  has_one :appointment, dependent: :destroy
end
