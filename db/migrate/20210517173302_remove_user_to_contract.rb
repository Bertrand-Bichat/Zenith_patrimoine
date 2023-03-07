class RemoveUserToContract < ActiveRecord::Migration[5.2]
  def change
    remove_reference :contracts, :user, index: true, foreign_key: true
  end
end
