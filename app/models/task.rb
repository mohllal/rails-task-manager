class Task < ApplicationRecord
  PROHIBITED_WORDS = ['later', 'eventually', 'someday']

  belongs_to :category, optional: true
  has_and_belongs_to_many :tags
  has_many :task_user_assignments
  has_many :users, through: :task_user_assignments

  validates :name, presence: true, length: { maximum: 50 }
  validates :position, numericality: { only_integer: true, greater_than: 0 }

  validate :description_has_no_prohibited_words

  before_validation :titlize_name
  before_validation :set_default_position,
    if: Proc.new {|t| t.position.blank? || t.position < 1 }
  before_create :log_create
  before_update :log_update
  after_save :log_save

  scope :completed, -> { where(completed: true) }
  scope :incompleted, -> { where(completed: false) }
  scope :sorted, -> { order(:position) }
  scope :search, -> (term) { where('LOWER(name) LIKE ?', "%#{term.downcase}%") }

private

  def description_has_no_prohibited_words
    if description.present? && description.downcase
      PROHIBITED_WORDS.each do |word|
        if description.include?(word)
          errors.add(:description, "cannot include the word '#{word}'")
        end
      end
    end
  end

  def titlize_name
    self.name = name.titleize
  end

  def set_default_position
    self.position = Task.where(category_id: category_id).count + 1
  end

  def log_create
    logger.debug("Task being created: #{name}")
  end

  def log_update
    logger.debug("Task being updated: #{name}")
  end

  def log_save
    logger.debug("Task was saved: #{name}")
  end
end
