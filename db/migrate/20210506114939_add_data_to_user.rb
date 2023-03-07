class AddDataToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :admin, :boolean, default: false, null: false
    add_column :users, :authorized, :boolean, default: false, null: false
    add_column :users, :pseudo, :string
  end
end
