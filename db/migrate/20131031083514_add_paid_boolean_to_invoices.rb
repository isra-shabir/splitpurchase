class AddPaidBooleanToInvoices < ActiveRecord::Migration
  def change
    change_table :invoices do |t|
      t.boolean :paid, default: false
    end
  end
end
