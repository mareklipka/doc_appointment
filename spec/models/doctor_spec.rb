# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Doctor do
  describe 'associations' do
    it { is_expected.to have_many :slots }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of :name }
    it { is_expected.to validate_presence_of :start_hour }
    it { is_expected.to validate_presence_of :end_hour }

    it do
      is_expected.to(
        validate_numericality_of(:start_hour).only_integer.is_in(Doctor::POSSIBLE_HOURS)
      )
    end

    it do
      is_expected.to(
        validate_numericality_of(:end_hour).only_integer.is_in(Doctor::POSSIBLE_HOURS)
      )
    end
  end
end
