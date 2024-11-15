class Category < ApplicationRecord
  belongs_to :user
  has_many :tasks, dependent: :nullify

  validates :name, presence: true, length: { within: 3..50 }

  scope :sorted, -> { order(:name) }
end
