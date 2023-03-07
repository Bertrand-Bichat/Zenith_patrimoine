class CreateDelegations < ActiveRecord::Migration[5.2]
  def change
    create_table :delegations do |t|
      t.references :assistant, foreign_key: { to_table: :users }
      t.references :agent, foreign_key: { to_table: :users }

      t.timestamps
    end
  end
end
