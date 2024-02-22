require 'cancan/matchers'
require 'rails_helper'

RSpec.describe Ability, type: :model do
  describe "abilities" do
    subject(:ability) { Ability.new(user) }
    context "when user is present" do
      let!(:user) { User.new }
      let!(:own_product) {user.products.new}
      let!(:other_product) { Product.new }
      it "can manage own products" do
        expect(ability).to be_able_to(:manage,own_product)
      end
      it "cannot manage other user's products" do
        expect(ability).not_to be_able_to(:manage,other_product)
      end
    end
    context "when user is nil" do
      let!(:user) { nil}
      let!(:product) { Product.new}
      it "cannot manage any product" do
        expect(ability).not_to be_able_to(:manage,product)
      end
    end
  end
end

# write this code for RSpec failure_message_for_should_not is deprecated.
RSpec::Matchers.define :be_able_to do |*args|
  match do |ability|
    ability.can?(*args)
  end

  failure_message do |ability|
    "expected to be able to #{args.map(&:inspect).join(" ")}"
  end

  failure_message_when_negated do |ability|
    "expected not to be able to #{args.map(&:inspect).join(" ")}"
  end
end