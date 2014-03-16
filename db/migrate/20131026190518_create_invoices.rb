class CreateInvoices < ActiveRecord::Migration
  def change
    create_table :invoices do |t|
    	t.belongs_to :group_purchase
     	t.string :debtor
      	t.text :reason
      	t.float :balance

      	t.timestamps
    end
  end
end
