#primary author: Isabella, Isra
class MembersController < ApplicationController
  def index
  	if member_signed_in?
  		@purchases_creditor = current_member.created_group_purchases
      @invoices_debitor = current_member.unpaid_invoices
      @invoices_debited = current_member.paid_invoices
      @payment_account  = current_member.payment_account
      if @payment_account.nil?
        flash[:error] = "Before you can make a payment you must create a payment account"
      end

  	end
  end

  def show
    @purchases_creditor = current_member.created_group_purchases
    @invoices_debitor = current_member.invoices
  	respond_to do |format|
  		format.html
    end
  end
end
