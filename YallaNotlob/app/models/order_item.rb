class OrderItem < ActiveRecord::Base
  belongs_to :user
  belongs_to :order
  default_scope { order('created_at DESC') }
end
