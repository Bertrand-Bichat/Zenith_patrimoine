class AddDateOfConsiderationToContract < ActiveRecord::Migration[5.2]
  def change
    add_column :contracts, :date_of_consideration, :datetime
  end
end
