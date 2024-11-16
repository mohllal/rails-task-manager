# frozen_string_literal: true

class AddUserReferenceToTags < ActiveRecord::Migration[7.0]
  def change
    add_reference :tags, :user, null: false, foreign_key: true, index: true
  end
end
