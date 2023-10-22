# frozen_string_literal: true

class CreateAppointments < ActiveRecord::Migration[7.1]
  def change
    create_table :appointments do |t|
      t.string :patient_name
      t.string :patient_phone
      t.references :slot, null: false, foreign_key: true

      t.timestamps
    end
  end
end
