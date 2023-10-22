# frozen_string_literal: true

class Slot < ApplicationRecord
  belongs_to :doctor
  has_one :appointment, dependent: :destroy
end
