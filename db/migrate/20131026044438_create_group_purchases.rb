class CreateGroupPurchases < ActiveRecord::Migration
  def change
    create_table :group_purchases do |t|
      t.string :purchaseName
      t.string :creatorName
      t.float :balance
      
      t.timestamps
    end

    create_table :group_purchases_members do |t|
    	t.belongs_to :group_purchase
    	t.belongs_to :member
    end
  end
end
