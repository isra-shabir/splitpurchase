#primary author: Isra 
class PaymentAccountsController < ApplicationController

  before_filter :authenticate_member!

  def new
    @payment_account = PaymentAccount.new
  end

  def create
    @payment_account               = PaymentAccount.new(params[:payment_account])
    @payment_account.member        = current_member
    @payment_account.charge_token  = params[:charge_token]

    pay_acc_hash         = params[:payment_account]
    pay_acc_hash[:email] = current_member.email
    @payment_account.deposit_token = @payment_account.create_recipient_account(pay_acc_hash)

    respond_to do |format|
      if @payment_account.save
        format.html { redirect_to :root, notice: 'Pay account was successfully created.' }
        format.json { render json: @payment_account, status: :created, location: @payment_account }
      else
        format.html { render action: edit }
        format.json { render json: @payment_account.errors, status: :unprocessable_entity }
      end
    end

  rescue Stripe::InvalidRequestError => e
    render action: "new", notice: "Stripe error while creating your account: #{e.message}"
  end

  def show
    render text: "no view yet"
  end

  def edit
    @payment_account = PaymentAccount.find(params[:id])
  end

  def update
    @payment_account            = PaymentAccount.find(params[:id])
    pay_acc_hash                = params[:payment_account]
    recipient_id                = @payment_account.deposit_token
    @payment_account.deposit_token = @payment_account.update_recipient_account(pay_acc_hash, recipient_id)
    
    respond_to do |format|
      if @payment_account.update_attributes(params[:payment_account])
        format.html { redirect_to :root, notice: 'Pay account was successfully updated.' }
        format.json { render json: @payment_account, status: :created, location: @payment_account }
      else
        format.html { render action: "edit" }
        format.json { render json: @payment_account.errors, status: :unprocessable_entity }
      end
    end

    rescue Stripe::InvalidRequestError => e
      @payment_account.errors.add(:stripe_error, ": #{e.message}")
      render action: "edit"
  end

  def destroy
    @payment_account = PaymentAccount.find(params[:id])
    @payment_account.destroy
    redirect_to :root, notice: "You payment account has been deleted."
  end


  def transfer
    @payment_account  = PaymentAccount.find(params[:id])
    invoice           = Invoice.find(params[:invoice_id])
    @payment_account.transfer_funds(invoice)

    redirect_to :root, notice: "Payment successful!"

    rescue Stripe::CardError => e
      flash[:error] = e.message
      redirect_to :root

  end   

end
