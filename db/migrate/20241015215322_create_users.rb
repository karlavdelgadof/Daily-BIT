# frozen_string_literal: true

class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :name, null: false
      t.string :email, null: false
      t.float :balance_usd, precision: 20, scale: 2, default: 0.0
      t.float :balance_btc, precision: 20, scale: 8, default: 0.0

      t.timestamps
    end
    add_index :users, :email, unique: true
  end
end
