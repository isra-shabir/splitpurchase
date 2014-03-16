class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.string :commenter
      t.text :body
      t.references :group_purchase

      t.timestamps
    end
    add_index :comments, :group_purchase_id
  end
end
