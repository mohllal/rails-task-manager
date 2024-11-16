# frozen_string_literal: true

# TaskUserAssignment is a model for task-user assignments
class TaskUserAssignment < ApplicationRecord
  belongs_to :task
  belongs_to :user
end
