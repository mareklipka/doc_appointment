# frozen_string_literal: true

class CreateDoctors < ActiveRecord::Migration[7.1]
  def change
    create_table :doctors do |t|
      t.string :name
      t.integer :start_hour
      t.integer :end_hour

      t.timestamps
    end
  end
end
