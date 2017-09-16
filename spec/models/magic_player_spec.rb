require "rails_helper"

describe MagicPlayer do
  describe "name uniqueness" do
    let!(:player1) { create(:magic_player) }
    let(:player2) do
      build(
        :magic_player,
        first_name: player1.first_name,
        last_name: player1.last_name,
        email: player1.email + "new",
        dci_number: player1.dci_number + "new"
      )
    end

    it "prevents the same first and last name" do
      expect(player2).to be_invalid
      expect(player2.errors[:last_name]).to include("First and last name already exist")
    end
  end
end
