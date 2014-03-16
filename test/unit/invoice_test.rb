#primary author: Kevin, Isabella
require 'test_helper'

class InvoiceTest < ActiveSupport::TestCase

  def test_invoice_creation
  	kwhite17 = members(:kwhite17)
  	snaga = members(:snaga)
  	snagaInv = invoices(:one)
  	snagaInv.debtor = snaga
    
    assert snagaInv.valid?, "Invoice with debtor valid"
    
    kwhite17Inv = invoices(:two)
    assert !kwhite17Inv.valid?, "Invoice without debtor invalid"
  end
end
