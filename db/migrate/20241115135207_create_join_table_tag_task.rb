# frozen_string_literal: true

# CreateJoinTableTagTask is a migration to create the join table between tags and tasks.
class CreateJoinTableTagTask < ActiveRecord::Migration[7.0]
  def change
    create_join_table :tags, :tasks do |t|
      t.index %i[tag_id task_id]
      t.index %i[task_id tag_id]
    end
  end
end
