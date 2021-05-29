class CreateAccounts < ActiveRecord::Migration[6.1]
  def change
    create_table :accounts do |t|
      t.bigint :user_id, null: false
      t.string :name,    null: false, unique: true
      t.integer :bank,    null: false
      t.datetime :deleted_at

      t.timestamps
    end

    add_index :accounts, %i[user_id name bank deleted_at], unique: true
  end
end
