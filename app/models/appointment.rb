# frozen_string_literal: true

class Appointment < ApplicationRecord
  belongs_to :slot

  validates :appointee_name, :appointee_phone, presence: true

  validate :slot_is_free, if: :slot_id_changed?

  private

  def slot_is_free
    return unless Appointment.exists?(slot_id:)

    errors.add(:slot_id, :not_free)
  end
end
