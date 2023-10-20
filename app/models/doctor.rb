# frozen_string_literal: true

class Doctor < ApplicationRecord
  validates :name, :start_hour, :end_hour, presence: true
  validates :start_hour, :end_hour, numericality: {
    only_integer: true, greater_than_or_equal_to: 0, less_than_or_equal_to: 24
  }
end
