#primary author: Isabella, (kevin - 3 lines)
class GroupPurchase < ActiveRecord::Base
  attr_accessible :balance, :purchaseName, :creatorName

  has_many :invoices
  has_many :debtors, :through=> :invoices, :class_name=>"Member"
  belongs_to :creditor , :class_name=>"Member"
  has_many :comments, dependent: :destroy

  def unallocated_balance
  	#iterate through all of the invoices that are part of this group_purchase
  	unallocated_balance = self.balance
  	self.invoices.each do |invoice|
  		unallocated_balance -= invoice.balance
  	end
  	return unallocated_balance
  end

  def other_debtors(member)
    #return all debtors part of this group that are not you
    other_debtors = Array.new
    self.debtors.each do |debtor|
      if debtor != member
        other_debtors.push(debtor)
      end
    end
    return other_debtors
  end

  def get_invoice_balance(debtor)
    self.invoices.each do |invoice|
      if invoice.debtor == debtor
        return invoice.balance
      end
    end
    return nil
  end

end
