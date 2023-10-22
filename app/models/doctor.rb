# frozen_string_literal: true

class Doctor < ApplicationRecord
  POSSIBLE_HOURS = (0..24)

  has_many :slots, dependent: :destroy

  validates :name, :start_hour, :end_hour, presence: true
  validates :start_hour, :end_hour, numericality: {
    only_integer: true, in: POSSIBLE_HOURS
  }
end
