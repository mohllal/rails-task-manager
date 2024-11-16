# frozen_string_literal: true

class TaskUserAssignment < ApplicationRecord
  belongs_to :task
  belongs_to :user
end
