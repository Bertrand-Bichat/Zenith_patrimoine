class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :customers, dependent: :destroy
  has_many :assistant_delegations, class_name: 'Delegation', foreign_key: "assistant_id", dependent: :destroy
  has_one :agent_delegation, class_name: 'Delegation', foreign_key: "agent_id", dependent: :destroy

  validates :email, presence: true, uniqueness: true
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :first_name, uniqueness: { scope: :last_name }

  def full_name
    "#{first_name} #{last_name}"
  end

  def find_assistant
    self.agent_delegation.assistant
  end

  def find_agents
    delegations = self.assistant_delegations.order(id: :asc)
    return delegations.includes([:agent]).map { |delegation| delegation.agent }
  end

  def find_agents_customers
    self.find_agents.map { |agent| agent.customers }.flatten
  end
end
