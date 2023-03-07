class Criterion < ApplicationRecord
  validates :content, presence: true
  validates :column, presence: true
end
