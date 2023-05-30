require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) {User.new(balance: 100)}

  context "when amount is positive" do
    it "increases the balance by the amount" do
      amount = 50
      user.top_up(amount)
      expect(user.balance).to eq(150)
    end
  end

  context "when amount is negative" do
    it "returns false" do
      amount = -50
      result = user.top_up(amount)
      expect(result).to be false
    end
  end
end
