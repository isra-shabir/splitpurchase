#primary author: Isabella
class CommentsController < ApplicationController
	before_filter :check_if_member_comments
	def create
	    @group_purchase = GroupPurchase.find(params[:group_purchase_id])
	    @comment = Comment.new
	    	@comment.body = params[:comment][:body]
	    	@comment.commenter = current_member.email
	    	@comment.group_purchase = @group_purchase
	    if @comment.valid?
	    	@comment.save
	    else
	    	flash[:error] = "You must specify text in your comment to create it"
	    end

	    redirect_to group_purchase_path(@group_purchase)
  	end

  	def destroy
	    @group_purchase = GroupPurchase.find(params[:group_purchase_id])
	    @comment = @group_purchase.comments.find(params[:id])
	    @comment.destroy
    	redirect_to group_purchase_path(@group_purchase)
  	end

  	private 

	def check_if_member_comments
		@group_purchase = GroupPurchase.find(params[:group_purchase_id])
		is_creditor = @group_purchase.creditor == current_member
		is_debitor = @group_purchase.debtors.include?(current_member)
		unless is_creditor or is_debitor
		  flash[:erorr] = "You must be a member of the group to make comments"
		  redirect_to root_path
		end
	end

end
