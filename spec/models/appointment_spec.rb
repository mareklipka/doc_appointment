# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Appointment do
  subject(:appointment) { build(:appointment) }

  describe 'associations' do
    it { is_expected.to belong_to :slot }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of :appointee_name }
    it { is_expected.to validate_presence_of :appointee_phone }

    it 'validates that the slot is free' do
      appointment.slot = create(:slot, :with_appointment)
      appointment.valid?

      expect(appointment.errors[:slot_id]).to include('is not free')
    end
  end
end
