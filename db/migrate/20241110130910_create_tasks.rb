# frozen_string_literal: true

# CreateTasks is a migration to create the tasks table.
class CreateTasks < ActiveRecord::Migration[7.0]
  def change
    create_table :tasks do |t|
      t.string :name, null: false
      t.text :description
      t.integer :position, null: false
      t.boolean :completed, null: false, default: false

      t.references :category, null: true, foreign_key: true

      t.timestamps
    end
  end
end
