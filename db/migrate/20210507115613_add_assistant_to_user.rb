class AddAssistantToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :assistant, :boolean, default: false, null: false
  end
end
