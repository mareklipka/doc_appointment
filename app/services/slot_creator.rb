# frozen_string_literal: true

class SlotCreator
  SLOT_DURATION = 30.minutes

  class << self
    def call(doctor, start_time, end_time)
      (start_time.to_i..end_time.to_i).step(SLOT_DURATION) do |starts_at|
        starts_at = Time.zone.at(starts_at)
        next unless slot_for?(doctor, starts_at)

        Slot.create(doctor:, starts_at:)
      end
    end

    private

    def slot_for?(doctor, starts_at)
      ends_at = starts_at + SLOT_DURATION

      within_work_hours?(doctor, starts_at, ends_at) &&
        (!starts_at.sunday? || !starts_at.saturday?) &&
        same_day?(starts_at, ends_at)
    end

    def within_work_hours?(doctor, starts_at, ends_at)
      starts_at.hour >= doctor.start_hour &&
        ((ends_at.hour <= doctor.end_hour && ends_at.min.zero?) ||
          (ends_at.hour < doctor.end_hour))
    end

    def same_day?(starts_at, ends_at)
      starts_at.day == ends_at.day
    end
  end
end
