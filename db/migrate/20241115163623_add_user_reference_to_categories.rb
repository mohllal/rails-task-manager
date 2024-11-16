# frozen_string_literal: true

# AddUserReferenceToCategories is a migration to add a user reference to the categories table
class AddUserReferenceToCategories < ActiveRecord::Migration[7.0]
  def change
    add_reference :categories, :user, null: false, foreign_key: true, index: true
  end
end
