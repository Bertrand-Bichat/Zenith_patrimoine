class Customer < ApplicationRecord
  belongs_to :user
  has_many :contracts, dependent: :destroy

  validates :name, presence: true, uniqueness: true
  validates :client_number, presence: true, uniqueness: true
end
