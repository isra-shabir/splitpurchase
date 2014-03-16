FactoryGirl.define do

  factory :payment_account do |f| 
    f.name              "Isra Shabir"
    f.routing_number    "110000000"
    f.account_number    "000123456789"
    f.country           "US"

  end

  factory :old_acc, parent: :payment_account do |f| 
    f.name              "I. M. Shabir"
  end

  factory :invalid_acc, parent: :payment_account do |f| 
    f.routing_number    "1100000"
  end


  factory :second_account do |f| 
    f.name              "Laila Shabir"
    f.routing_number    "110000000"
    f.account_number    "000123456789"
    f.country           "US"
  end


end