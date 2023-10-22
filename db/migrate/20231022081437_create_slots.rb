# frozen_string_literal: true

class CreateSlots < ActiveRecord::Migration[7.1]
  def change
    create_table :slots do |t|
      t.references :doctor, null: false, foreign_key: true
      t.datetime :starts_at

      t.timestamps
    end
  end
end
