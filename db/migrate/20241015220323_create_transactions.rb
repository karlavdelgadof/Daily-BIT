class CreateTransactions < ActiveRecord::Migration[7.0]
  def change
    create_enum :transaction_type, %w[buy sell]

    create_table :transactions do |t|
      t.references :user, null: false, foreign_key: true
      t.enum :current_transaction, enum_type: :transaction_type
      t.decimal :amount_sent
      t.string :currency_sent
      t.decimal :amount_received
      t.string :currency_received
      t.decimal :exchange_rate, precision: 20, scale: 8

      t.timestamps
    end
  end
end
