# frozen_string_literal: true

# User model
class User < ApplicationRecord
  has_secure_password

  EMAIL_REGEX = /\A[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,4}\Z/i

  has_many :categories
  has_many :tags
  has_many :task_user_assignments, dependent: :destroy
  has_many :tasks, through: :task_user_assignments

  validates :first_name, presence: true, length: { maximum: 25 }
  validates :last_name, presence: true, length: { maximum: 50 }
  validates :email,
            presence: true,
            length: { maximum: 50 },
            uniqueness: { case_sensitive: false },
            format: { with: EMAIL_REGEX }
  validates :password, presence: true, length: { minimum: 6 }, if: -> { new_record? || !password.nil? }
  validates_acceptance_of :terms_of_service

  scope :sorted, -> { order(:last_name, :first_name) }

  def full_name
    "#{first_name} #{last_name}"
  end

  def last_name_first
    "#{last_name}, #{first_name}"
  end

  def abberviated_name
    "#{first_name[0]}. #{last_name}"
  end
end
