class CreateMagicPlayers < ActiveRecord::Migration[5.0]
  def change
    create_table :magic_players do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :dci_number
      t.float :store_credit
      t.timestamps
    end
  end
end
