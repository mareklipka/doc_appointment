# frozen_string_literal: true

namespace :populate do
  desc 'Populate slots for a month ahead'
  task slots: :environment do
    start_time = (
      Slot.maximum(:starts_at) || Time.zone.now.change(min: 30, sec: 0)
    ) + SlotCreator::SLOT_DURATION
    end_time = 1.month.from_now

    exit(0) if start_time > end_time # no need to populate

    Doctor.find_each do |doctor|
      SlotCreator.call(doctor, start_time, end_time)
    end
  end
end
