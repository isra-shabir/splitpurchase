class AddDebtorToInvoices < ActiveRecord::Migration
  def change
  	change_table :invoices do |t|
      	t.belongs_to :debtor
  	end
  end
end
