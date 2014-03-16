class CreatePaymentAccounts < ActiveRecord::Migration
  def change
    create_table :payment_accounts do |t|

      t.string :name      
      t.string :routing_number
      t.string :account_number
      t.string :country

      t.string :deposit_token
      t.string :charge_token


      t.belongs_to :member
      
      t.timestamps
    end
  end
end
