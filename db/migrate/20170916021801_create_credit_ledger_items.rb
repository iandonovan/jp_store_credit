class CreateCreditLedgerItems < ActiveRecord::Migration[5.0]
  def change
    create_table :credit_ledger_items do |t|
      t.integer :magic_player_id
      t.float :amount
      t.timestamps
    end
  end
end
