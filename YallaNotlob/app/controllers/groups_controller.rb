class GroupsController < ApplicationController
	def new
		@group = current_user.groups
	end

	def create
		#check if the value is null
		if group_params[:name] == ""
			puts "this param is empty"
			@error_null = "Please put some data here"
			render json: @error_null
		else
			puts "this params is full of data"
			#lets check if this user has a group with the same name
			#if the name exist	
			if Group.exists? name: group_params[:name]
				#this group is already exist
				@error_exist = "This Group Name is already exist , please change !"
				render json: @error_exist
			else
				#it is new group
				@user = current_user
				@group = @user.groups.create(group_params)
				render json: @group
			end
		end
		

	end #function

	def show
	end

	def destroy
		@group = Group.find(params[:id])
		@group.destroy
		redirect_to :back
	end

	#get name by selcted id
	def getName
		@group = Group.find(params[:id])
		@group_members =[]
		@group.group_members.each do |member|
			@group_members.push(User.find(member.user_id));
		end
	 	@group_data = {name: @group.name , members: @group_members}
		render json: @group_data
	end

	def addFriend
		#Now i have this friend data from the data base and i already have the groupId
		#get the friend name
		@friendName = params[:username]	
			#check if it is null
		if @friendName.empty?
			puts "empty friend"
			@error_null = {'nullValue': 'Please insert some data !'}
			render json: @error_null
		else
			#check if it is wrong type
			if User.exists? username: @friendName
			#it is really a user  
			puts "this guy is full of data"	
			@fid = User.find_by(username: params[:username])
			@gid = params[:groupId]
			@group = @fid.group_members.create(group_id: @gid)
			render json: @fid

			else
			#it is a robot
			@error_notExist = {'notExist': 'This user is not exist !'}
			render json: @error_notExist
			end	
		end		
		
	
	end #function 

	def deletefriend
		@friend = User.find_by(id: params[:friendId])
		@group_member = GroupMember.find_by(group_id: params[:groupId],user_id: params[:friendId])
		@group_member.destroy
		render json: @friend
	end

	private
	def group_params
		params.require(:group).permit(:name)
	end
end
