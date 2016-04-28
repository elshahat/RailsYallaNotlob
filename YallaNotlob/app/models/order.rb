class Order < ActiveRecord::Base
  belongs_to :user
  has_many :items, :dependent => :delete_all
  has_many :order_invites, :dependent => :delete_all
  enum status: { Waiting: 1, Finished: 0}
  enum type: { Breakfast: 1, Lunch: 2, Dinner: 3}
end