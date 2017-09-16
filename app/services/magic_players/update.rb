class MagicPlayers::Update < ActiveInteraction::Base
  object :magic_player
  hash :params do
    string :first_name, default: nil
    string :last_name, default: nil
    string :email, default: nil
    string :dci_number, default: nil
    float :store_credit, default: nil
  end

  def execute
    if params[:store_credit] != magic_player.store_credit
      update_player_and_ledger!
    else
      magic_player.update(params)
    end
    merge_errors! if magic_player.invalid?
    magic_player
  end

  private

  def update_player_and_ledger!
    delta = params[:store_credit] - magic_player.store_credit
    if magic_player.update(params)
      magic_player.credit_ledger_items.create(amount: delta)
    end
  end

  def merge_errors!
    magic_player.errors.each do |k, v|
      errors.add(k, v)
    end
  end
end
