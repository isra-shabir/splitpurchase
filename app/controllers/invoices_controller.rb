#primary author: Isabella, Kevin
class InvoicesController < ApplicationController
 
  before_filter :check_creditor_invoice

  # GET /invoices
  # GET /invoices.json
  def index
    #@invoices = Invoice.all
    respond_to do |format|
      format.html {redirect_to members_index, notice: 'Link prohibited.'}
      format.json { render json: @invoices }
    end
  end

  # GET /invoices/1
  # GET /invoices/1.json
  def show
    @invoice = Invoice.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @invoice }
    end
  end

  # GET /invoices/new
  # GET /invoices/new.json
  def new
    @group_purchase = GroupPurchase.find(params[:group_purchase_id])
    @invoice = Invoice.new
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @invoice }
    end
  end

  # GET /invoices/1/edit
  def edit
    @invoice = Invoice.find(params[:id])
  end

  def find_members
    @group_purchase = GroupPurchase.find(params[:group_purchase_id])    
    members_edit = Member.retreive_typeahead_members(params[:q], @group_purchase)
    members_edit.to_json
    puts members_edit
    respond_to do |format|
      format.html
      format.json { render :json => members_edit}
    end
  end

  # POST /invoices
  # POST /invoices.json
  def create
    respond_to do |format|
      begin 
        @group_purchase = GroupPurchase.find(params[:group_purchase_id])
        @invoice = Invoice.new
          @invoice.debtor = Member.where(id: params[:invoice][:debtor]).first
          @invoice.balance = params[:invoice][:balance]
          @invoice.group_purchase = @group_purchase
        @invoice.save

        @num_debtors = @group_purchase.debtors.length
        
        @group_purchase.invoices.each do |charge|
          charge.balance = charge.group_purchase.balance/(@num_debtors)
        end

          if @invoice.save
            format.html { redirect_to group_purchase_path(@group_purchase), notice: 'Invoice was successfully created.' }
            format.json { render json: @invoice, status: :created, location: @invoice }
          else
            format.html { render action: "new", notice: 'An error occurred.' }
            format.json { render json: @invoice.errors, status: :unprocessable_entity }
          end
        rescue
          format.html {redirect_to new_group_purchase_invoice_path, notice: 'Invalid email.'}
        end
    end
  end

  # PUT /invoices/1
  # PUT /invoices/1.json
  def update
    @invoice = Invoice.find(params[:id])

    respond_to do |format|
      if @invoice.update_attributes(params[:invoice])
        format.html { redirect_to @invoice, notice: 'Invoice was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @invoice.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /invoices/1
  # DELETE /invoices/1.json
  def destroy
    @invoice = Invoice.find(params[:id])
    @invoice.destroy

    respond_to do |format|
      format.html { redirect_to invoices_url }
      format.json { head :no_content }
    end
  end

  private 
  def check_creditor_invoice
    @group_purchase = GroupPurchase.find(params[:group_purchase_id])
    if @group_purchase.creditor != current_member
      flash[:erorr] = "You must be the group creator create invoices"
      redirect_to root_path
    end
  end

end
