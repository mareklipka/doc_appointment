# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Slot do
  describe 'associations' do
    it { is_expected.to belong_to :doctor }
  end
end
