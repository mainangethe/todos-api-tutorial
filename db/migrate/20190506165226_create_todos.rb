# frozen_string_literal: true

class CreateTodos < ActiveRecord::Migration[5.2]
  def change
    create_table :todos, id: :uuid do |t|
      t.string :title
      t.string :created_by

      t.timestamps
    end
  end
end
