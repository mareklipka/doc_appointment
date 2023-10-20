# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Doctor do
  subject(:doctor) { described_class.new }

  describe 'validations' do
    it { is_expected.to validate_presence_of :name }
    it { is_expected.to validate_presence_of :start_hour }
    it { is_expected.to validate_presence_of :end_hour }

    it do
      expect(doctor).to validate_numericality_of(:start_hour).only_integer
                                                             .is_greater_than_or_equal_to(0)
                                                             .is_less_than_or_equal_to(24)
    end

    it do
      expect(doctor).to validate_numericality_of(:end_hour).only_integer
                                                           .is_greater_than_or_equal_to(0)
                                                           .is_less_than_or_equal_to(24)
    end
  end
end
