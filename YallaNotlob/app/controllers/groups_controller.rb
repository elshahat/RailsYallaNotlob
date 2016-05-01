class GroupsController < ApplicationController
	def new
		@group = Group.all
	end

	def create
		@user = current_user
		@group = @user.groups.create(group_params)
		redirect_to :back
		#group_path(@group)
		#redirect_to :action => 'suppliers', :id => @product.id 

	end

	#show the groups
	def show
		#redirect_to :back
	end

	def destroy
		@group = Group.find(params[:id])
		@group.destroy
		redirect_to :back
	end

	#get name by selcted id
	def getName
		@group = Group.find(params[:id])
		#@name = Group.find(:name, :conditions => ["id = ?", :id])
		@group_members =[]
		@group.group_members.each do |member|
			@group_members.push(User.find(member.user_id));
		end
	 	@group_data = {name: @group.name , members: @group_members}
		render json: @group_data
	end

	def addFriend
		#Now i have this friend data from the data base and i already have the groupId
		@fid = User.find_by(username: params[:username])
		@gid = params[:groupId]
		@group = @fid.group_members.create(group_id: @gid)
		render json: @fid
	end

	private
	def group_params
		params.require(:group).permit(:name)
	end
end
