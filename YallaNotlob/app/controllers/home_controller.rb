class HomeController < ApplicationController
  def index

  	if current_user
		@orders = Order.all.where(user_id: current_user.id).order(created_at: :desc) 
		# --------------------------

		@all = current_user.friends.orders
		puts @all.inspect
		# @all = Order.joins(:user).select("*")

	else
    	redirect_to '/users/sign_in'
    end
  end
end
