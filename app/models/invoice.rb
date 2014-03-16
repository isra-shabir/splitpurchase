#primary author: Isabella, kevin
class Invoice < ActiveRecord::Base
  attr_accessible :balance, :debtor, :paid
  belongs_to :group_purchase
  belongs_to :debtor, :class_name=> "Member"

  validate :require_debtor, :require_balance

	def require_debtor
      errors.add(:invoices, "must specify the email of a person who owes you money") if debtor == nil
    end
    
    def require_balance
    	errors.add(:invoices, "must specify a nonzero balance") if balance == 0
    	errors.add(:invoices, "must specify a balance") if balance == nil
    end

end
