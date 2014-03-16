class DropGroupPurchaseMembersTable < ActiveRecord::Migration
  def up
  	drop_table :group_purchases_members
  end

  def down
  	create_table :group_purchases_members do |t|
    	t.belongs_to :group_purchase
    	t.belongs_to :member
    end
  end
end
