class Delegation < ApplicationRecord
  belongs_to :assistant, class_name: 'User', foreign_key: "assistant_id"
  belongs_to :agent, class_name: 'User', foreign_key: "agent_id"
end
