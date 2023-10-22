# frozen_string_literal: true

class CreateAppointments < ActiveRecord::Migration[7.1]
  def change
    create_table :appointments do |t|
      t.string :appointee_name
      t.string :appointee_phone
      t.references :slot, null: false, foreign_key: true

      t.timestamps
    end
  end
end
