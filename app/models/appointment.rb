# frozen_string_literal: true

class Appointment < ApplicationRecord
  belongs_to :slot

  validates :patient_name, :patient_phone, presence: true

  validate :slot_is_free, if: :slot_id_changed?

  def entity
    Entity.new(self)
  end

  class Entity < Grape::Entity
    expose :id
    expose :patient_name
    expose :patient_phone
    expose :slot_starts_at, as: :starts_at

    private

    def slot_starts_at
      object.slot.starts_at
    end
  end

  private

  def slot_is_free
    return unless Appointment.exists?(slot_id:)

    errors.add(:slot_id, :not_free)
  end
end
