require "rails_helper"

describe MagicPlayers::Update do
  let(:subject) { described_class.run(magic_player: player, params: params) }
  let(:player) { create(:magic_player) }

  context "without changing store credit" do
    let(:params) do
      {
        first_name: "New First",
        last_name: "New Last",
        email: "new@email.com",
        dci_number: "55555555",
        store_credit: player.store_credit
      }
    end

    it "updates the player" do
      expect { subject }.to change { player.reload.first_name }.to("New First")
    end

    it "does not create a credit ledger item" do
      expect { subject }.to_not change { CreditLedgerItem.count }
    end
  end

  context "with increasing store credit" do
    let(:params) do
      {
        first_name: "New First",
        last_name: "New Last",
        email: "new@email.com",
        dci_number: "55555555",
        store_credit: player.store_credit + 10
      }
    end

    it "updates the player" do
      expect { subject }.to change { player.reload.store_credit }
    end

    it "creates a credit ledger item" do
      expect { subject }.to change { player.credit_ledger_items.count }.by(1)
      expect(player.credit_ledger_items.last.amount).to eq(10)
    end
  end

  context "with decreasing store credit" do
    let(:params) do
      {
        first_name: "New First",
        last_name: "New Last",
        email: "new@email.com",
        dci_number: "55555555",
        store_credit: player.store_credit - 10
      }
    end

    it "updates the player" do
      expect { subject }.to change { player.reload.store_credit }
    end

    it "creates a credit ledger item" do
      expect { subject }.to change { player.credit_ledger_items.count }.by(1)
      expect(player.credit_ledger_items.last.amount).to eq(-10)
    end
  end

  context "with an invalid credit change" do
    let(:params) do
      {
        first_name: "New First",
        last_name: "New Last",
        email: "new@email.com",
        dci_number: "55555555",
        store_credit: player.store_credit - 2*(player.store_credit)
      }
    end

    it "does not update the player" do
      expect { subject }.to_not change { player.reload.store_credit }
    end

    it "does not create a ledger item" do
      expect { subject }.to_not change { CreditLedgerItem.count }
    end
  end
end
