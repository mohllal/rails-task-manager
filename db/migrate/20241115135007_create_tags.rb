# frozen_string_literal: true

# CreateTags is a migration to create the tags table.
class CreateTags < ActiveRecord::Migration[7.0]
  def change
    create_table :tags do |t|
      t.string :name, null: false

      t.timestamps
    end
  end
end
