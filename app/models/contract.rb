class Contract < ApplicationRecord
  belongs_to :customer

  validates :contract_number, presence: true, uniqueness: true
  validates :instance_reason, presence: true
  validates :customer_class, presence: true
  validates :explanation, presence: true
end
