class CreditLedgerItem < ApplicationRecord
  validates :amount, numericality: true
  belongs_to :magic_player

  def display_amount
    amount > 0 ? "+$#{amount}" : "-$#{-1* amount}"
  end
end
