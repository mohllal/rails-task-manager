# frozen_string_literal: true

# AddUserReferenceToTags is a migration to add a user reference to the tags table.
class AddUserReferenceToTags < ActiveRecord::Migration[7.0]
  def change
    add_reference :tags, :user, null: false, foreign_key: true, index: true
  end
end
