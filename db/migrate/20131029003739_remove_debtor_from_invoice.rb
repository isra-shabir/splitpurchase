class RemoveDebtorFromInvoice < ActiveRecord::Migration
  def up
  	remove_column :invoices, :debtor
  end

  def down
  	add_column :invoices, :debtor, :string
  end
end
