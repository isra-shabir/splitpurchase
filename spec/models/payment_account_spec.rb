require 'spec_helper'

describe PaymentAccount do

  it "has a valid factory" do
    FactoryGirl.create(:payment_account).should be_valid
  end

  it "is invalid without a name" do
    FactoryGirl.build(:payment_account, name: nil).should_not be_valid
  end

  it "is invalid without a card number" do
    FactoryGirl.build(:payment_account, card_number: nil).should_not be_valid
  end

  it "is invalid without a account number" do
    FactoryGirl.build(:payment_account, account_number: nil).should_not be_valid
  end

  it "is invalid without a routing number" do
    FactoryGirl.build(:payment_account, routing_number: nil).should_not be_valid
  end
  
end