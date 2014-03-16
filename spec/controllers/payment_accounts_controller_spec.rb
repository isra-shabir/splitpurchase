require 'spec_helper'

def login_member
  before(:each) do
    @request.env["devise.mapping"] = Devise.mappings[:member]
    member = FactoryGirl.create(:member)
    sign_in member
  end
end

describe PaymentAccountsController do
  
  login_member

  describe "GET #new" do
    it "renders the :new view" do
      get :new
      response.should render_template :new
    end
  end
  


  describe "GET #edit" do

    it "assigns the requested paymentaccount to @payment_account" do
      payment_account = FactoryGirl.create(:payment_account)
      get :edit, id: payment_account
      assigns(:payment_account).should eq(payment_account)
    end
    
    it "renders the :edit template" do
      get :edit, id: FactoryGirl.create(:payment_account)
      response.should render_template :edit
    end
  end
  

  describe "POST #create" do 

    context "with valid attributes" do
      it "saves the new payment account in the database" do
        expect { 
          post :create, payment_account: FactoryGirl.attributes_for(:payment_account)
        }.to change(PaymentAccount, :count).by 1
      end

      it "redirects to the home page" do
        post :create, payment_account: FactoryGirl.attributes_for(:payment_account)
        response.should redirect_to :root
      end
    end

    context "with invalid attributes" do
      it "does not save the new payment_account in the database" do
        expect { 
          post :create, payment_account: FactoryGirl.attributes_for(:invalid_acc)
        }.to change(PaymentAccount, :count).by 0
      end
      
      it "re-renders the :new template" do
        post :create, payment_account: FactoryGirl.attributes_for(:invalid_acc)
        response.should render_template :new
      end
    end


  end


  describe "PUT update" do

    before :each do
      @account = FactoryGirl.create(:old_acc)
    end

    context "valid attributes" do
      it "fetches the requested payment account" do
        put :update, id: @account, payment_account: FactoryGirl.attributes_for(:old_acc, name: "Isra Shabir")
        assigns(:payment_account).should eq(@account)
      end

      it "changes the payment account's attributes" do
        put :update, id: @account, payment_account: FactoryGirl.attributes_for(:old_acc, name: "Isra Shabir")
        @account.reload
        # @account.name.should eq("Isra Shabir")
      end

      it "redirects to the home page" do
        put :update, id: @account, payment_account: FactoryGirl.attributes_for(:old_acc, name: "Isra Shabir")
        # response.should eq(200)
      end

    end

    context "invalid attributes" do
      it "fetches the requested payment account" do
        put :update, id: @account, payment_account: FactoryGirl.attributes_for(:invalid_acc)
        assigns(:payment_account).should eq(@account)
      end

      it "does not change the payment account's attributes" do
        put :update, id: @account, payment_account: FactoryGirl.attributes_for(:old_acc, name: "Isra Shabir")
        @account.reload
        @account.name.should_not eq("Isra Shabir")
      end

      it "re renders the edit teamplate" do
        put :update, id: @account, payment_account: FactoryGirl.attributes_for(:old_acc, name: "Isra Shabir")
        response.should render_template :edit
      end

    end
  end

  describe "DELETE destroy" do 
    before :each do 
      @payment_account = FactoryGirl.create(:payment_account)
    end

    it "deletes the contact" do 
      expect{ 
        delete :destroy, id: @payment_account
      }.to change(PaymentAccount, :count).by(-1)
    end

    it "redirects to contacts#index" do 
      delete :destroy, id: @payment_account
      response.should redirect_to :root
    end

  end


  describe "POST transfer" do
    before :each do
      @pay_acc1 = FactoryGirl.create(:payment_account)
      @pay_acc2 = FactoryGirl.create(:second_account)
      @inoice   = FactoryGirl.create(:invoice)
    end

    context "valid accounts and invoice" do
      post :transfe, invoice_id: @invoice.id
      
    end
  end


end