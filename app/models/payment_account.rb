#primary author: Isra
class PaymentAccount < ActiveRecord::Base
  attr_accessible :name, :routing_number, :account_number, :country
  
  validates :name,           presence: true
  validates :routing_number, presence: true
  validates :account_number, presence: true
  validates :country,        presence: true

  belongs_to :member


  def create_recipient_account pay_acc_hash
    user_as_recipient = Stripe::Recipient.create(
                          :name => pay_acc_hash[:name],
                          :type => "individual",
                          :email => pay_acc_hash[:email],
                          :bank_account => {
                                :country => pay_acc_hash[:country],
                                :routing_number => pay_acc_hash[:routing_number],
                                :account_number => pay_acc_hash[:account_number]
                          }
                        )
    user_as_recipient.id
  end

  def update_recipient_account pay_acc_hash, recipient_id
    recipient         = Stripe::Recipient.retrieve(recipient_id)
    recipient.name    = pay_acc_hash[:name]
    recipient.bank_account = {
                                :country => pay_acc_hash[:country],
                                :routing_number => pay_acc_hash[:routing_number],
                                :account_number => pay_acc_hash[:account_number]
                              }
    recipient.save
    recipient.id
  end    

  def transfer_funds invoice
    amount            = (invoice.balance*100).to_i
    recipient         = invoice.group_purchase.creditor
    description       = invoice.group_purchase.purchaseName

    transfer = Stripe::Transfer.create(
      :amount => amount,
      :currency => "usd",
      :recipient => recipient.payment_account.deposit_token,
      :statement_descriptor => description
    )

    invoice.paid = true
    invoice.save
  end


end
