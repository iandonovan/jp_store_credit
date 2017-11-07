require "rails_helper"

describe MagicPlayer do
  describe "first_name" do
    let(:player) do
      build(
        :magic_player,
        first_name: nil,
        last_name: "Last",
        email: "email@email.com",
        dci_number: "129218"
      )
    end

    it "is required" do
      expect(player).to be_invalid
      expect(player.errors[:first_name]).to include("can't be blank")
    end
  end

  describe "first_name and last_name" do
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

    it "have a scoped uniqueness" do
      expect(player2).to be_invalid
      expect(player2.errors[:last_name]).to include("First and last name already exist")
    end
  end

  describe "email and last name" do
    let(:player) do
      build(
        :magic_player,
        first_name: "First",
        last_name: nil,
        email: nil,
        dci_number: "129218",
        store_credit: 0
      )
    end

    it "are not required" do
      expect(player).to be_valid
    end
  end

  describe "email and dci_number" do
    let(:player1) { create(:magic_player) }
    let(:player2) do
      build(
        :magic_player,
        first_name: player1.first_name + "new",
        last_name: player1.last_name + "new",
        email: player1.email,
        dci_number: player1.dci_number
      )
    end

    it "must be unique" do
      expect(player2).to be_invalid
      expect(player2.errors[:email]).to include("has already been taken")
      expect(player2.errors[:dci_number]).to include("has already been taken")
    end
  end
end
