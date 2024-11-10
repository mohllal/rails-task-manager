class Task < ApplicationRecord
  belongs_to :category, optional: true

  validates :name, presence: true
  validates :name, uniqueness: true
end
