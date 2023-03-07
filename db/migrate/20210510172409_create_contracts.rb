class CreateContracts < ActiveRecord::Migration[5.2]
  def change
    create_table :contracts do |t|
      t.references :customer, foreign_key: true
      t.string :instance_reason
      t.string :customer_class
      t.string :contract_number
      t.string :explanation
      t.string :prioritization
      t.string :monitoring
      t.date :date_of_consideration
      t.string :gideon_number
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
