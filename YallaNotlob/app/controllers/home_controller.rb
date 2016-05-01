class HomeController < ApplicationController
  def index

  	if current_user
		@orders = Order.all.where(user_id: current_user.id).order(created_at: :desc) 
		# --------------------------

		# @all = Order.joins(:user , :friendship).select("*").where(friendship: {user_id: current_user.id}).where(friendship: {friend_id: 2})
		
		@all = Order.joins(:user).select("*")


	else
    	redirect_to '/users/sign_in'
    end
  end
end
