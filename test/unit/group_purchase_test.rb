#primary author: Isabella, Kevin
require 'test_helper'

class GroupPurchaseTest < ActiveSupport::TestCase

  def test_purchase_creation
  	one = group_purchases(:one)
  	two = group_purchases(:two)
  	kwhite17 = members(:kwhite17)
  	tank = members(:tank)
  	assert_equal one.creatorName, kwhite17.email, "Emails match."
  	assert_equal two.creatorName, tank.email, "Emails match"
  	assert one.balance == 1.51, "Balance is correct."
  	refute two.balance != 3.05, "Balance is correct."
  end
    
  #test that balance calculation is correct
  def test_unallocated_balance
    kwhite17 = members(:kwhite17)
    tank = members(:tank)
    group_purchase2 = group_purchases(:two)

    assert_equal group_purchase2.unallocated_balance, group_purchase2.balance, "No invoices added test"
    
    invoice1 = invoices(:one)
    invoice1.debtor = kwhite17
    invoice1.group_purchase = group_purchase2
    invoice1.save
    group_purchase2.invoices << invoice1
    group_purchase2.save

    assert_equal group_purchase2.unallocated_balance, group_purchase2.balance - invoice1.balance, "One invoice unallocated balance"

    invoice2 = invoices(:two)
    invoice2.debtor = tank
    invoice2.group_purchase = group_purchase2
    invoice2.save
    group_purchase2.invoices << invoice2
    group_purchase2.save

    assert_equal group_purchase2.unallocated_balance, group_purchase2.balance - invoice1.balance - invoice2.balance, "Test multiple invoices balances correct"

  end

  #when create invoice the invoice should appear at group_purchases.invoices
  def test_add_invoice
    kwhite17 = members(:kwhite17)
    tank = members(:tank)
    invoices_expected = Array.new
        
    invoice1 = invoices(:one)
    group_purchase1 = group_purchases(:one)
    invoice1.group_purchase = group_purchase1
    invoice1.debtor = kwhite17
    invoice1.save

    invoices_expected.push(invoice1)

    assert_equal group_purchase1.invoices, invoices_expected, "Test adding invoice"
  
  end

  def test_get_invoice_balance
    kwhite17 = members(:kwhite17)
    tank = members(:tank)

    group_purchase1 = group_purchases(:one)

    invoice1 = invoices(:one)
    invoice1.debtor = kwhite17
    invoice1.group_purchase = group_purchase1
    invoice1.save

    assert_equal group_purchase1.get_invoice_balance(kwhite17), invoice1.balance, "Test that invoice balances agree"
  end

  def test_other_debtors
    kwhite17 = members(:kwhite17)
    tank = members(:tank)

    other_debtors_expected = Array.new
    other_debtors_expected.push(tank)

    group_purchase1 = group_purchases(:one)

    invoice1 = invoices(:one)
    invoice1.debtor = kwhite17
    invoice1.group_purchase = group_purchase1
    invoice1.save

    invoice2 = invoices(:two)
    invoice2.debtor = tank
    invoice2.group_purchase = group_purchase1
    invoice2.save

    assert_equal group_purchase1.other_debtors(kwhite17), other_debtors_expected, "Test other debtors not you"
  end



end
