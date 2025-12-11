class Task < ApplicationRecord
  validates :title, presence: true, length: { maximum: 200 }

  validates :status, inclusion: { in: %w[ongoing completed dropped] }

  validates :priority, numericality: {
    only_integer: true,
    greater_than_or_equal_to: 1,
    less_than_or_equal_to: 3
  }
end
