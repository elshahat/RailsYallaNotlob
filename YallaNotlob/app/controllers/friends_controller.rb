class FriendsController < ApplicationController

	def create
		#@friend_id = User.find_by username: ["username = ?", friend_params]
		#@friend_id = User.find(:conditions => ["username = ?", friend_params])
		#@friend_id = User.where	(["username = ?", friend_params]).first
		#@fid = User.find_by(:id,:conditions => ["username = ?", friend_params],)
		#render plain: User.find_by(friend_params).inspect
		@fid = User.find_by(friend_params)
		@user = current_user
		@friend = @user.friendships.create(friend_id: @fid.id)
		redirect_to :back
	end


	def getId
		#@name = User.find(:id, :conditions => ["username = ?", :username])
		@name = User.find(params[:username])
		render json: @name
	end

	private 
	def friend_params
		params.require(:friend).permit(:username)
	end


end
