#primary author: Isabella, Isra
class Member < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
  # attr_accessible :title, :body
  has_many :invoices, :foreign_key=>"debtor_id"
  has_many :group_purchases, :through=> :invoices
  has_many :created_group_purchases, :class_name=>"GroupPurchase", :foreign_key=> "creditor_id"
  has_one  :payment_account

  def self.search(search)
    if search
      where('email LIKE ?', "%#{search}%")
    else
      scoped
    end
  end

  def self.retreive_typeahead_members(query, group_purchase)
    members = Member.search(query).map { |m| {:id => m.id, :name => m.email } }
    members_edit = Array.new
    members.each do |mbr|
      @is_debtor = group_purchase.debtors.include?(Member.find(mbr[:id]))
      @is_creditor =  group_purchase.creditor.email == mbr[:name]
      unless @is_creditor or @is_debtor
        members_edit.push(mbr)
      end
    end
    unless members_edit.any?
      if @is_debtor
        members_edit.push({:status => 'alreadyAdded'})
      elsif @is_creditor
        members_edit.push({:status => 'creditor'})
      end
    end
    return members_edit
  end

  def paid_invoices
    self.invoices.select { |inv| inv.paid }
  end

  def unpaid_invoices
    self.invoices.select { |inv| not inv.paid }
  end

  def has_payment_account?
    not self.payment_account.nil?
  end

end
