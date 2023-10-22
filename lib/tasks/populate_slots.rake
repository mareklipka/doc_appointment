# frozen_string_literal: true

namespace :populate do
  desc 'Populate slots for a month ahead'
  task slots: :environment do
    start_time = (
      Slot.maximum(:starts_at) || Time.zone.now.change(min: 30, sec: 0)
    ) + Slot::DURATION
    end_time = 1.month.from_now

    exit(0) if start_time > end_time # no need to populate

    Doctor.find_each do |doctor|
      (start_time.to_i..end_time.to_i).step(Slot::DURATION) do |starts_at|
        starts_at = Time.zone.at(starts_at)
        ends_at = starts_at + Slot::DURATION
        next unless starts_at.hour >= doctor.start_hour &&
                    ((ends_at.hour <= doctor.end_hour && ends_at.min.zero?) ||
                     (ends_at.hour < doctor.end_hour)) && # handle work end
                    !starts_at.sunday? && !starts_at.saturday? && # skip weekends
                    starts_at.day == ends_at.day # skip slots that cross days

        Slot.create(doctor:, starts_at:)
      end
    end
  end
end
