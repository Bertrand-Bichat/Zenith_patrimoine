class RemoveDateOfConsiderationFromContract < ActiveRecord::Migration[5.2]
  def change
    remove_column :contracts, :date_of_consideration, :date
  end
end
