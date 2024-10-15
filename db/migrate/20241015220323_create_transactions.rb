class CreateTransactions < ActiveRecord::Migration[7.0]
  def change
    create_enum :transaction_type, %w[buy sell]
    create_enum :currency, %w[USD BTC]


    create_table :transactions do |t|
      t.references :user, null: false, foreign_key: true
      t.enum :current_transaction, enum_type: :transaction_type
      t.decimal :amount_sent
      t.enum :currency_sent, enum_type: :currency
      t.decimal :amount_received
      t.enum :currency_received, enum_type: :currency
      t.decimal :exchange_rate, precision: 20, scale: 8

      t.timestamps
    end
  end
end
