class CreateCriterions < ActiveRecord::Migration[5.2]
  def change
    create_table :criterions do |t|
      t.string :content
      t.string :column

      t.timestamps
    end
  end
end
