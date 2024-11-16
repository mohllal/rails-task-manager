# frozen_string_literal: true

# CreateCategories is a migration to create the categories table.
class CreateCategories < ActiveRecord::Migration[7.0]
  def change
    create_table :categories do |t|
      t.string :name, null: false

      t.timestamps
    end
  end
end
