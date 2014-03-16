#primary author: Isabella
class Comment < ActiveRecord::Base
  belongs_to :group_purchase
  attr_accessible :body, :commenter

  validates :body, presence: true
end
