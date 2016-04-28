class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :orders, :dependent => :delete_all       
  has_many :order_items, :dependent => :delete_all
  has_many :friendships, :dependent => :delete_all
  has_many :friends, :through => :friendships
  has_many :groups, :dependent => :delete_all
  has_many :group_members, :dependent => :delete_all
  has_many :order_invites, :dependent => :delete_all

end
