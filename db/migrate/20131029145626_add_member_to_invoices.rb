class AddMemberToInvoices < ActiveRecord::Migration
  def change
  	change_table :invoices do |t|
      	t.belongs_to :member
  	end
end
end
