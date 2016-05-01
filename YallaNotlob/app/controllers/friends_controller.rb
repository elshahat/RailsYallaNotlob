class FriendsController < ApplicationController

	def new
		@friend_to_user = User.joins("INNER JOIN friendships ON friendships.friend_id = users.id")	
	end
	
	def create
		#@friend_id = User.find_by username: ["username = ?", friend_params]
		#@friend_id = User.find(:conditions => ["username = ?", friend_params])
		#@friend_id = User.where	(["username = ?", friend_params]).first
		#@fid = User.find_by(:id,:conditions => ["username = ?", friend_params],)
		#render plain: User.find_by(friend_params).inspect
		@fid = User.find_by(username: params[:username])
		@user = current_user
		@friend = @user.friendships.create(friend_id: @fid.id)
		render json: @fid
	end

	def show
		@friend_to_user = User.joins("INNER JOIN friendships ON friendships.friend_id = users.id")	
		#render plain: User.joins("INNER JOIN friendships ON friendships.friend_id = users.id").select(:username, :image).inspect
		#render plain: current_user.inspect
		#render plain: User.includes(:friendships).where("('current_user.id') LIKE ?", 'friend_id').references(:friendships).inspect
		#render plain: User.joins(:friendships).where("users.id = ? AND friendships.friend_id = ?", 'current_user.id', 'users.id').inspect
	end

	def destroy
		#@user = User.find(params[:param1])
		@friend = Friendship.find_by(user_id: params[:param1],friend_id: params[:param2])
		#@friend = Friendship.find("SELECT * FROM friendships WHERE friendships.user_id = "+params[:param1]+" AND friendships.friend_id = "+params[:param2]+" LIMIT 1")
		@friend.destroy
		redirect_to :back
	end

	#private 
	#def friend_params
	#params.require(:friend).permit(:username)
	#end

end
