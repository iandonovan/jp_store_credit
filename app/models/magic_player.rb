class MagicPlayer < ApplicationRecord
  validates :email, :dci_number, uniqueness: true
  validates :store_credit, numericality: { greater_than_or_equal_to: 0 }
  has_many :credit_ledger_items

  def full_name
    [first_name, last_name].join(" ")
  end
end
