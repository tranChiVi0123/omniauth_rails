class CreateTransactions < ActiveRecord::Migration[6.1]
  def change
    create_table :transactions do |t|
      t.bigint  :account_id,           null: false
      t.decimal :amount, default: 0.0, null: false
      t.string  :transaction_type,     null: false
      t.datetime :deleted_at
      t.string :uuid


      t.timestamps
    end

    add_index :transactions, %i[account_id deleted_at]
  end
end
