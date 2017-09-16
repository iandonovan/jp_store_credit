class MagicPlayer < ApplicationRecord
  validates :email, uniqueness: true, if: "email.present?"
  validates :dci_number, uniqueness: true, if: "dci_number.present?"
  validates :store_credit, numericality: { greater_than_or_equal_to: 0 }
  validates :last_name, uniqueness: { scope: :first_name, message: "First and last name already exist" }
  has_many :credit_ledger_items

  def full_name
    [first_name, last_name].join(" ")
  end
end
