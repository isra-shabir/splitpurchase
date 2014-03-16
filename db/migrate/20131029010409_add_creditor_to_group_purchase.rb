class AddCreditorToGroupPurchase < ActiveRecord::Migration
  def change
  	change_table :group_purchases do |t|
  		t.belongs_to :creditor
  	end
  end
end
