class HomeController < ApplicationController
  def index

  	if current_user
		@orders = Order.all.where(user_id: current_user.id).order(created_at: :desc) 
		puts @orders
    else
    	redirect_to '/users/sign_in'
    end
  end
end
