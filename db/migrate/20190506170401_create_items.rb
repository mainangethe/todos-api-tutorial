class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items, id: :uuid do |t|
      t.string :name
      t.boolean :done
      t.references :todo, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
