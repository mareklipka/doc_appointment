# frozen_string_literal: true

class AddIndexesToSlotsStartsAt < ActiveRecord::Migration[7.1]
  def change
    add_index :slots, :starts_at
    add_index :slots, %i[doctor_id starts_at], unique: true
  end
end
