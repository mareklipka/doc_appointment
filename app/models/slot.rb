# frozen_string_literal: true

class Slot < ApplicationRecord
  DURATION = 30.minutes

  belongs_to :doctor
  has_one :appointment, dependent: :destroy

  scope :free, -> { where.missing(:appointment) }

  class Entity < Grape::Entity
    expose :id
    expose :patient_name
    expose :patient_phone
    expose :starts_at
    expose :created_at
    expose :updated_at

    def patient_name
      object.appointment&.patient_name
    end

    def patient_phone
      object.appointment&.patient_phone
    end
  end
end
